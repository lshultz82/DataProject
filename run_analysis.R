	#BLOCK 1
	
	#creating files for test_df
	subject_test<-read.table(file.path('UCI HAR Dataset','subject_test.txt'))
	x_test<-read.table(file.path('UCI HAR Dataset','x_test.txt'))
	y_test<-read.table<-(file.path('UCI HAR Dataset','y_test.txt'))
	temp_column_names<-read.table(file.path('UCI HAR Dataset','features.txt'))
	column_names<-temp_column_names[,2]
	
	#merge first tables,rename
	temp_merge<-cbind(subject_test,y_test)
	names(temp_merge)<-c('subject_id','activity')
	
	#rename columns in x_test from codebook, merge
	names(x_test)<-column_names
	temp_merge<-cbind(temp_merge,x_test)
	
	#extract mean() & std() variables, including 7 variables averaged across angles, maintaining id & 		activity 
	search<-grep("mean\\()|std\\()",names(temp_merge))
	cols<-c(1:2,search,555:563)
	merge_test<-temp_merge[,cols]
	
	#BLOCK 2 repeat above series for train_df
	
	subject_train<-read.table(file.path('UCI HAR Dataset','subject_train.txt'))
	x_train<-read.table(file.path('UCI HAR Dataset','x_train.txt'))
	y_train<-read.table<-(file.path('UCI HAR Dataset','y_train.txt'))
	
	temp_merge<-cbind(subject_train,y_train)
	names(temp_merge)<-c('subject_id','activity')
	
	names(x_train)<-column_names
	temp_merge<-cbind(temp_merge,x_train)
	
	search<-grep("mean\\()|std\\()",names(temp_merge))
	cols<-c(1:2,search,555:563)
	merge_train<-temp_merge[,cols]

	#BLOCK 2.5 merge train & test
	
	final_merge<-rbind(merge_test,merge_train)
	
	#BLOCK 3 Relabelling the activity variable, referring to "./activity_labels.txt"
	
	library(plyr)
	final_merge$activity<-mapvalues(final_merge$activity,c("1","2","3","4","5","6"),c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
	
	#BLOCK 4 Cleaning the Column Names,removing metacharacters, refining CamelCase 
	names(final_merge)<-gsub("\\-","_",names(final_merge))
	names(final_merge)<-gsub("\\()","",names(final_merge))
	names(final_merge)<-gsub("_m","_M",names(final_merge))
	names(final_merge)<-gsub("_s","_S",names(final_merge))
	
	#BLOCK 5 Create secondary data set finding the average of each variable for each subject in each activity level
	library(reshape2)
	melt<-melt(final_merge,id=c("subject_id","activity"))
	data<-dcast(melt,subject_id+activity~variable,mean)
	
	#BLOCK 6 Creating an exportable data set
	tidyData <-data
	write.table(tidyData, file="./tidydata.txt", sep="\t", row.names=FALSE)
	
