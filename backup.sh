#sean oconnor
#c13455028

#Back up and restore program with menu functions

# check if user is SU or back up folder  is made for first time running

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
        #-p if doesnt exist create
        mkdir -p /BACKUP
        mkdir -p /archieve1

#Global vars
cd /
EXLCUDE_DIR="/* --exclude=/lib/* --exclude=/bin/* --exclude=/sbin/* --exclude=/us$
DATE=`date +%d%m%y-%X`
FILEN=Backup-$DATE.tar.gz
#place holder for backup directory, used for log print outs
B=0


#used for generating log files
# takes in parameter for error checking
# writes log if sucees or fail
logf()
{
        echo -e "/n creating log file"

        if [ $1 -eq "1" ]
        then
                FALOG = " === $DATE - $FILEN -  Back up failed  === "
                echo $FALOG >> /BACKUP/LogFile.log
        elif [ $1 -eq "2" ]
        then
                SULOG = " === $DATE - $FILEN -  Back up success === "
				 echo $SULOG >> /BACKUP/LogFile.log
        elif [ $1 -eq "3" ]
        then
                RELOG = " === $DATE - $FILEN - Restore happened === "
                echo $RELOG >> /BACKUP/LogFile.log
        fi

}

#menu functions

# creates back up and places them indside the archieve folder
part1()
{
        clear
        echo "All files back up to root directory has  begun apart from those execluded



        #$DATE address the date file and uses it to name the files while backing $
		 #back up copies and doesn't delete them. add in --delete after -ad for de$

        #F = file name
        #X = EXTRACT
        #p = keep instact file structur and persminsions after compress
        #V = list the files being trasnsfered
        tar cvpfz /archieve1/$FILEN $EXLCUDE_DIR && rsync -av --delete  /archieve1/ /BACKUP/
        if [ "$" -eq "0" ]
        then
                logf 2
        else

                logf 2
        fi

        echo -e "\n =============== files are backed up ==============="

}
# This function moves to the root folder
# lists the contents so user can input a directory
# then reads in input
# stores input in "location1
# then makes the directory folder  if it doesn't exist in the inputted location
# moves to the selected folder directory
# then writes with tar into the selected folder with backups
part2()
{
        clear

        echo -e "Custom folder selection \n"
        cd /
        ls -d */
        echo "Write in an absolute path to back up to \n"
        read location1
        cd /$location1/
        mkdir -p BACKUPFOLDER
        location2="$location1/BACKUPFOLDER/"
        echo "Are you sure to write into : $location1"
		 echo -e "\n [Y/N]"
        read op1
        # checking if upper case Y or lowercase
        if test $op1 = "Y" -o $op1 = "y"
        then
                tar cvpfz /archieve1/$FILEN $EXLCUDE_DIR && rsync -av  /archieve1$
                if [ "$?" -eq "0" ]
                then
                        echo -e "\n Files have been backed up"
                        logf 2
                else
                        echo -e "\n Failed "
                        logf 1
                fi
        fi




}
part3()
{
        op1=1
        clear
        cd /
        mkdir -p RestoreDirectory
        cd /BACKUP

        while [ $op1 -eq 1 ]
        do

                echo "Files inside backup folder "
                echo -e " \n Choose which backup you want. Must be named exactly"
                echo -e "\n To exit menu press 9"
                #all file names that contain the word Backup, are displayed
                ls | grep Backup

                read RESTORE
                if [ $RESTORE -eq 9 ]
                then
                        op=2
                        break
                fi
                echo -e "\n \n Confirm restore at location $RESTORE ?"
                echo -e "\n [Y/N]"
                read op2

                if [ $op2 -eq "Y" -o $op2 -eq "y" ]
                then
                        cd /
                        tar zxvf $RESTORE -C /RestoreDirectory/
                        op1 = 0
                        logf 3
                elif [ $op2 -eq "n" -o -eq "N" ]
                then
                        op1 = 2
                fi
        done

}

part9()
{
        echo "Application exiting"
        exit 0
}
# Start while loop to keep menu functions
s=1
while [ $s -eq 1 ]
do
        echo -e "\n"
        echo "==================================="
        echo " Back up and restore"
        echo "==================================="
        echo "Press 1 for back up too route"
        echo "Press 2 for backup to custom folder"
        echo "Press 3 for restore"
        echo "Press 9 for exit"

        read OP
        case $OP in
                1)part1;;
                2)part2;;
                3)part3;;
                9)part9;;
        esac
done





