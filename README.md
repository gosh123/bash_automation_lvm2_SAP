# bash automation filesystems and LVM2 for SAP modules (2008)
Shell scripting automation: filesystems and LVM2 creation for SAP modules/applications. vgcfgbackup/vgcfgrestore 

I created the following scripts a few years ago for a customer interested in migrating a large legacy SAP installation on HP-UX to newer infrastructure with SuSE Linux Enterprise. A simpler naming scheme for each SAP filesystem would have made the scripting automation easier and hence the operating costs (this naming scheme was a requirement according to SAP people). These scripts could be rewritten with less lines of similar code with the help of two-dimensional arrays, but they were initially good enough for creating a large number of filesystems on several environments (testing, development, QA, production, staging, etc). Time used: 1 day of work.

Consider also the following links that can help you to replicate a LVM2 layout to multiple environments:

	* Use vgcfgbackup and vgcfgrestore to back up metadata on LVM http://www.techrepublic.com/blog/opensource/use-vgcfgbackup-and-vgcfgrestore-to-back-up-metadata-on-lvm/3221 
	* How to backup LVM configuration on linux (vgcfgbackup & vgcfgrestore) http://www.expertslogin.com/linux-administration/how-to-backup-lvm-configuration-on-linux/ 
	* How to quickly restore lvm2 volumes from saved layout http://www.mindtwist.de/main/linux/3-linux-tipps/47-how-to-quickly-restore-lvm2-volumes-from-saved-layout.html 
	* Logical Volume Backup https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/backup.html 
	* Backing Up Volume Group Metadata https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/VG_backup.html 
	* Recovering Physical Volume Metadata https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/mdatarecover.html 	* Logical Volume Manager Administration. LVM Administrator Guide. https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/ 
	* pvresize http://www.linux-tutorial.info/modules.php?name=ManPage&sec=8&manpage=pvresize 


