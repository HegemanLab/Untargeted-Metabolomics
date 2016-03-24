## for xcms see
## http://bioconductor.org/packages/devel/bioc/html/xcms.html
library(xcms)

setwd("C:/Users/Lab/Desktop/Coding_Bits/untargetedMetabolomics")

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


filesN <- c(
  "ACM_sept16_T1R2_GL21_method1-neg.mzXML",
  "ACM_sept16_T1R2_GL2_method1-neg.mzXML",
  "ACM_sept16_T1R2_GL7_method1-neg.mzXML",
  "ACM_sept16_T1R3_GL7_method1-neg.mzXML",
  "ACM_sept16_T1R3_GL20_method1-neg.mzXML",
  "ACM_sept16_T1R3_GL21_method1-neg.mzXML"
)

filesP <- c(
  "ACM_sept16_T1R2_GL21_method1-pos.mzXML",
  "ACM_sept16_T1R2_GL2_method1-pos.mzXML",
  "ACM_sept16_T1R2_GL7_method1-pos.mzXML",
  "ACM_sept16_T1R3_GL7_method1-pos.mzXML",
  "ACM_sept16_T1R3_GL20_method1-pos.mzXML",
  "ACM_sept16_T1R3_GL21_method1-pos.mzXML"
)

# Reads in files and creates an XCMS Set object  # SN up reduces number of peaks. Prefilter ^ >> 

xsetN <- xcmsSet(filesN, method = "MSW", peakScaleRange = 5, amp.Th = .032)
xsetP <- xcmsSet(filesP, method = "MSW", peakScaleRange = 1, amp.Th = .008)

# For ungrouped and unfilled output run this. 
trimmedN <- trim(xsetN)
trimmedP <- trim(xsetP)

write.csv(trimmedN, file = "method1-set-neg.csv", row.names = FALSE) # change text inside quotes to what the negative file should be named
write.csv(trimmedP, file = "method1-set-pos.csv", row.names = FALSE) # change text inside quotes to what the positive file should be named
###

groupedN <- group(xsetN)
groupedP <- group(xsetP)

filledN <- fillPeaks(groupedN)
filledP <- fillPeaks(groupedP)
filledN
filledP

trimmedN <- trim(filledN)
trimmedP <- trim(filledP)

### Output name is left to be adjusted by user
write.csv(trimmedN, file = "acm-untargeted-neg.csv", row.names = FALSE) # change text inside quotes to what the negative file should be named
write.csv(trimmedP, file = "acm-untargeted-pos.csv", row.names = FALSE) # change text inside quotes to what the positive file should be named
 
filledN
filledP
# intensity retention time and m/z for positive and negative separately
# Run all 4 files (Tri files and ACM files from Drive) <- also want VanKs (scatter and heat)
# and duplicate and compounds list (same starter compound list too)


### NOTE AND RANDOM SNIPPETS

# Command prompt: 
# msconvert *.RAW --mzXML --filter "peakPicking true 1" --filter "polarity negative" -o C:/Users/Lab/Desktop/examples -v



setwd("C:/Users/Lab/Desktop/examples")

msconvert <- c("msconvert.exe")

FILES <- c(
  "Tri3_25.raw",
  "Tri4_25.raw"
)

# FILES <- list.files(recursive=TRUE, full.names=TRUE, pattern="\\.raw")
show(FILES)
for (i in 1:length(FILES))
{system (paste(msconvert," --mzXML --filter \"peakPicking true 1\" --filter \"polarity positive\" -o C:/rprocessing/converted/posmzxmlfiles -v",FILES[i]))}
for (i in 1:length(FILES))
{system (paste(msconvert," --mzXML --filter \"peakPicking true 1\" --filter \"polarity negative\" -o C:/rprocessing/converted/negmzxmlfiles -v",FILES[i]))}







