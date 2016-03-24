## for xcms see
## http://bioconductor.org/packages/devel/bioc/html/xcms.html
library(xcms)

# Set working directory to where your files are
setwd("C:/Users/Lab/Desktop/Coding_Bits/untargetedMetabolomics")

### This note and bit of commmand line code will just help speed up some of the name entry. 
# reads in files from a .txt file with this name. Each filename is on 
# a new line. (can do this by having a folder with all files in it,
# then navigate into that folder and enter the followign command:
# >>> dir /b > filenames.txt)
# files <- scan("filenames.txt", what = "", sep="\n")

trim <- function(filledset){
  trimmedmatrix  <- cbind(filledset@peaks[,1],filledset@peaks[,4],filledset@peaks[,7])
  colnames(trimmedmatrix)  <- c('mz', 'rt', 'into')
  trimmedmatrix
}

# Example file lists
# filesN <- c(
#   "ACM_sept16_T1R2_GL21_method1-neg.mzXML",
#   "ACM_sept16_T1R2_GL2_method1-neg.mzXML",
#   "ACM_sept16_T1R2_GL7_method1-neg.mzXML",
#   "ACM_sept16_T1R3_GL7_method1-neg.mzXML",
#   "ACM_sept16_T1R3_GL20_method1-neg.mzXML",
#   "ACM_sept16_T1R3_GL21_method1-neg.mzXML"
# )
# 
# filesP <- c(
#   "ACM_sept16_T1R2_GL21_method1-pos.mzXML",
#   "ACM_sept16_T1R2_GL2_method1-pos.mzXML",
#   "ACM_sept16_T1R2_GL7_method1-pos.mzXML",
#   "ACM_sept16_T1R3_GL7_method1-pos.mzXML",
#   "ACM_sept16_T1R3_GL20_method1-pos.mzXML",
#   "ACM_sept16_T1R3_GL21_method1-pos.mzXML"
# )



# Reads in files and creates an XCMS Set object
xsetN <- xcmsSet(filesN, method = "MSW", peakScaleRange = 5, amp.Th = .032)
xsetP <- xcmsSet(filesP, method = "MSW", peakScaleRange = 1, amp.Th = .008)

### For ungrouped and unfilled output run this. 
trimmedN <- trim(xsetN)
trimmedP <- trim(xsetP)

write.csv(trimmedN, file = "method1-set-neg.csv", row.names = FALSE) # change text inside quotes to what the negative file should be named
write.csv(trimmedP, file = "method1-set-pos.csv", row.names = FALSE) # change text inside quotes to what the positive file should be named
###

### For grouped and filled results, run this. 
groupedN <- group(xsetN)
groupedP <- group(xsetP)

filledN <- fillPeaks(groupedN)
filledP <- fillPeaks(groupedP)

trimmedN <- trim(filledN)
trimmedP <- trim(filledP)

# Output name is left to be adjusted by user
write.csv(trimmedN, file = "acm-untargeted-neg.csv", row.names = FALSE) # change text inside quotes to what the negative file should be named
write.csv(trimmedP, file = "acm-untargeted-pos.csv", row.names = FALSE) # change text inside quotes to what the positive file should be named
###



### NOTE AND RANDOM SNIPPETS

## This command line code can be used with MS Convert (from ProteoWizard) to convert a single .RAW into either a positive or negative polarity mzXML
# Command prompt: 
# msconvert *.RAW --mzXML --filter "peakPicking true 1" --filter "polarity negative" -o C:/Users/Lab/Desktop/examples -v
# Note: may not need the peak picking fliter and also if you want both pos and neg you must run the command twice and chnage "polarity negative" to "polarity positive"

