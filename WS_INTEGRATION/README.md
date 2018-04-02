# SFDX  App
This app is used to track changes and progress for the Wellspring/Sophia Migration. 

## SFDX Actions and Commands
Starting a new project

	Create project in DX
	Modified the project-sfdx.json if needed
	Create scratch org
		$ sfdx force:org:create -a Alias -s (set to default) -f config/project-scratch-def.json -d (duration in days)
	Log in
		$ sfdx force:org:open
	
	
Adding commits

	$ git checkout (branch/master)
	$ git pull
	
	Make changes
	
	$ sfdx force:source:pull -u ScratchOrgName
	$ git add -A
	$ git commit -m "comment"
	$ git push origin master
	
Adding to branch

	$ git checkout master
	$ git pull
	
	Make changes
	
	$ git checkout -b BranchName
	
Converting the project

	Commit all changes, push to git
	$ git checkout master
	$ git pull
	sfdx force:source:convert --outputdir mdapi_output_dir/
		The metadata is now stored locally ready to deploy

Deploying the project

	sfdx force:mdapi:deploy -u ScratchOrgName --deploydir mdapi_output_dir/ -w 30
	
	
Data collection and deployment

	To export divisions:
	sfdx force:data:tree:export -p -u DivisionUpdate -d OrgData -q "SELECT Name, Active__c, Campus__c, Campus_WXID__c, Campus_XID__c, Cost_Center__c, Cost_Center_WXID
	__c, Cost_Center_XID__c, Department__c, Department_WXID__c, Department_XID__c, School__c, School_WXID__c, School_XID__c, Unit__c, Unit_WXID__c, Unit_XID__c  FROM Di
	vision__c"
	
	To import:
	sfdx force:data:tree:import -f OrgData/Accounts.json -u InventionCreate
	sfdx force:data:tree:import -p OrgData/Account-Contact-plan.json -u InventionCreate


## Resources



## Description of Files and Directories
force-app/ holds all the data that gets pulled from source

OrgData/ stores the sample data to test with

mdapi_output_dir is the directory that stores the metadata that is ready to deploy.
    To export the data from source:
    	sfdx force:source:convert --outputdir mdapi_output_dir/
    To deploy:
        sfdx force:mdapi:deploy -u ScratchOrgName --deploydir mdapi_output_dir/ -w 30

## Issues


