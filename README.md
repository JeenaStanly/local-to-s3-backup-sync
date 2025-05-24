# local-to-s3-backup-sync
How to use Windows Task Scheduler to automate Local Directory sync with AWS S3

what if all the files were saved in a folder on the system, and every day at a predetermined time, a type of automation took place, moving newly added data into a secure and durable storage system like S3?

I found a way to do this with the help of “Task Scheduler."

Here is how…

## Prerequisites
- An AWS account
- A Windows Operating System (OS)
## What is the Windows Task Scheduler?

The Windows Task Scheduler is a tool included with Windows that allows predefined actions to be automatically executed whenever a certain set of conditions is met. For example, you can schedule a task to run a backup script every night or have it send you an e-mail whenever a certain system event occurs.

## What is S3?

Amazon S3, or Amazon Simple Storage Service, is a service offered by Amazon Web Services that provides object storage through a web service interface. Amazon S3 uses the same scalable storage infrastructure that Amazon.com uses to run its e-commerce network.

### Step 1: Download AWS CLI

Firstly, you download the AWS CLI for Windows.

After downloading, open your system Command Prompt by typing “CMD” on your Windows search bar, selecting “Open,” and running the following command: “aws configure.” If you have installed the AWS CLI correctly, you should have the following display where you input your AWS Access Key ID, AWS Secret Access Key, default region, and default output format. 

![image](https://github.com/user-attachments/assets/83d27e6b-392b-4153-9f4b-de1b67d2d788)

### Step 2: Create an S3 bucket

Now, sign in to the same account configured on your AWS CLI. You are going to create an S3 bucket that is going to be synced with the local directory.

Navigate to the S3 console and select “Create bucket." On this page fill in the following blanks

- Enter the name of your bucket (must be a unique name)

- Choose your region (same as the one you selected on the AWS CLI)

- Object Ownership: This column has two options

ACL enabled: An ACL is an access control list, and if you enable this option, we can grant other AWS accounts and users access to the objects in your bucket.

ACL disabled: When the ACL option is enabled, only policies will be able to enable access to our buckets.


Select ACL is disabled, so your bucket is not available to the public.

Scroll down on the creation page and select “create bucket." Now you have successfully created an S3 bucket.


Now, navigate to the “Command Prompt” on your system and run “aws s3 ls.” If you are in the right account, this command will display a list of S3 buckets in the AWS account.


### Step 3: Create a “Task” on Task Scheduler

Go to the Windows search bar and type in “Task Scheduler." select "Open,” and you will see the below display. Select "Create Task."


In the Task window, enter a task name.


Navigate right to the “Triggers” section and click on "New."This is where we choose how frequently we want this trigger to automate this sync, for example, daily, weekly, or monthly.


Navigate right again to the “Actions” tab and select “New.”


You will see the below display asking for a program/script, This is where we add our batch script that will run the s3 sync command.

What is a batch script and how do we create one?

A batch script is a text file containing certain commands that are executed in sequence. It is used to simplify certain repetitive tasks or routines in the Windows, DOS, and OS/2 operating systems, and is also used in complex network and system administration.

To create one for this project, Open up a blank notepad on your system and enter the following command.

aws s3 sync C:\Users\YourLocalDirectory s3://s3BucketName
This command will use the S3 cli command to sync the local directory folder to this particular S3 bucket. In order to make this a batch script, we click on “save as” and add “.bat” at the end after adding the name. This automatically turns this Notepad editor file into an executable batch script.


Click on “Browse” on the Actions tab and add this batch script as an action. That is, whenever the specified time in the trigger approaches, the script runs immediately and updates the S3 bucket with ONLY newly added file(s) in the system folder, according to the triggers and actions.


Navigate right to settings and check the box that says “Run task as soon as possible after a scheduled start is missed.” This will make sure that if an action was missed for whatever reason, for example, a dead battery. It would automatically start whenever your laptop comes on.


On the Task Scheduler homepage, select the task you just created and click “Run.”


If everything was done successfully, immediately after clicking "Run,” you will see a similar display to the one below, where the files begin to get uploaded to the specified S3 bucket.


If you followed the steps up until this point, you will have successfully established a sync connection between your local system and an AWS S3 bucket.
