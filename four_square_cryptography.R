#!/usr/bin/env Rscript

library(optparse)



make_keyword_sqr <- function(keyword){
  key_list = unique(unlist(strsplit(tolower(keyword), split="")))
  alpha_list = unlist(strsplit("abcdefghijklmnoprstuvwxyz", split=""))
  unused_alpha_list=setdiff(alpha_list, key_list)
  key_sqr = matrix(NA, ncol=5, nrow=5)
  for (i in 1:length(key_list)){
    key_sqr[i]=key_list[i]
  }
  for (i in (length(key_list)+1):25){
    key_sqr[i]=unused_alpha_list[i-length(key_list)]
  }
  return(t(key_sqr))
}


make_sqr<-function(){
  alpha_matrix=matrix(NA,ncol=5,nrow=5)
  alpha_list=unlist(strsplit("abcdefghijklmnoprstuvwxyz",split=""))
  for (i in 1:25){
    alpha_matrix[i]=alpha_list[i]
  }
  return(t(alpha_matrix))
}


encrypt_4sqr<-function(keyword1, keyword2, inputtext){
  up_left_sqr = make_sqr()
  up_right_sqr = make_keyword_sqr(keyword2)
  down_left_sqr = make_keyword_sqr(keyword1)
  down_right_sqr = make_sqr()
  
  input_list=unlist(strsplit(tolower(gsub("[^[:alnum:]]", "", inputtext)), split= ""))
  outputtext=""
  if (length(input_list)%%2==0){
    for (i in 1:(length(input_list)/2)){
      if (input_list[2*i-1]=="q" || input_list[2*i]=="q"){
        if (input_list[2*i-1]=="q"){charout1="q"}
        if (input_list[2*i]=="q"){charout2="q"}
      }
      else{
      loc1=which(up_left_sqr==input_list[2*i-1], arr.ind=TRUE)
      loc2=which(down_right_sqr==input_list[2*i], arr.ind=TRUE)
      charout1=down_left_sqr[loc2[1], loc1[2]]
      charout2=up_right_sqr[loc1[1], loc2[2]]
      }
      outputtext=paste0(outputtext, charout1, charout2)
    }
  }
  else{
    for (i in 1:((length(input_list)-1)/2)){
      if (input_list[2*i-1]=="q" || input_list[2*i]=="q"){
        if (input_list[2*i-1]=="q"){charout1="q"}
        if (input_list[2*i]=="q"){charout2="q"}
      }
      else{
        loc1=which(up_left_sqr==input_list[2*i-1], arr.ind=TRUE)
        loc2=which(down_right_sqr==input_list[2*i], arr.ind=TRUE)
        charout1=down_left_sqr[loc2[1], loc1[2]]
        charout2=up_right_sqr[loc1[1], loc2[2]]
      }
      outputtext=paste0(outputtext, charout1, charout2)
    }
    outputtext=paste0(outputtext, input_list[length(input_list)])
  }
  return(outputtext)
}

decrypt_4sqr<-function(keyword1, keyword2, inputtext){
  up_left_sqr = make_sqr()
  up_right_sqr = make_keyword_sqr(keyword2)
  down_left_sqr = make_keyword_sqr(keyword1)
  down_right_sqr = make_sqr()
  
  input_list=unlist(strsplit(tolower(gsub("[^[:alnum:]]", "", inputtext)), split= ""))
  outputtext=""
  if (length(input_list)%%2==0){
    for (i in 1:(length(input_list)/2)){
      if (input_list[2*i-1]=="q" || input_list[2*i]=="q"){
        if (input_list[2*i-1]=="q"){charout1="q"}
        if (input_list[2*i]=="q"){charout2="q"}
      }
      else{
        loc1=which(down_left_sqr==input_list[2*i-1], arr.ind=TRUE)
        loc2=which(up_right_sqr==input_list[2*i], arr.ind=TRUE)
        charout1=up_left_sqr[loc2[1], loc1[2]]
        charout2=down_right_sqr[loc1[1], loc2[2]]
      }
      outputtext=paste0(outputtext, charout1, charout2)
    }
  }
  else{
    for (i in 1:((length(input_list)-1)/2)){
      if (input_list[2*i-1]=="q" || input_list[2*i]=="q"){
        if (input_list[2*i-1]=="q"){charout1="q"}
        if (input_list[2*i]=="q"){charout2="q"}
      }
      else{
        loc1=which(down_left_sqr==input_list[2*i-1], arr.ind=TRUE)
        loc2=which(up_right_sqr==input_list[2*i], arr.ind=TRUE)
        charout1=up_left_sqr[loc2[1], loc1[2]]
        charout2=down_right_sqr[loc1[1], loc2[2]]
      }
      outputtext=paste0(outputtext, charout1, charout2)
    }
    outputtext=paste0(outputtext, input_list[length(input_list)])
  }
  return(outputtext)
}


if (!interactive()) {
  option_list<-list(
    make_option(c("--key1"),type="character", help="1st Keyword for encryption/decryption", metavar="KEYWORD 1"),
    make_option(c("--key2"), type="character", help="2nd Keyword for encryption/decryption", metavar="KEYWORD 2"),
    make_option(c("-p", "--process"), type="character", help="Mention whether to encrypt or decrypt", metavar="PROCESS (ENCRYPT OR DECRYPT)"),
    make_option(c("-i", "--input"), type="character", help="Input .txt file containing the text to be encrypted or decrypted", metavar="INPUT .TXT FILE"),
    make_option(c("-o", "--output"), type="character", help="Output .txt file containing the text to be encrypted or decrypted", metavar="OUTPUT .TXT FILE")
  )
  parser<-OptionParser(option_list=option_list)
  opt<-parse_args(parser)
  
  lines<-readLines(opt$input, warn=FALSE)
  inputtext<-paste(lines)
  
  
  if(tolower(opt$process)=="encrypt"){
    outputtext=encrypt_4sqr(opt$key1, opt$key2, inputtext)
  }
  else if(tolower(opt$process)=="decrypt"){
    outputtext=decrypt_4sqr(opt$key1, opt$key2, inputtext)
  }
  else{stop("`--process` must be ENCRYPT or DECRYPT")}
}
writeLines(outputtext, con=opt$output)
