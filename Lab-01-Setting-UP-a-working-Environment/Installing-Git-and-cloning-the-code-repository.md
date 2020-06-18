# Installing Git
We are using Git to clone the sample code accompanying this book from its GitHub repository. If you already have Git installed on your computer, you can skip this section:

To install Git on your macOS, use the following command in a Terminal window:
```
$ choco install git
```
To install Git on Windows, open a PowerShell window and use Chocolatey to install it:
```
PS> choco install git -y
```
Finally, on your Debian or Ubuntu machine, open a Bash console and execute the following command:
```
$ sudo apt update && sudo apt install -y git
```
Once Git is installed, verify that it is working. On all platforms, use the following:
```
$ git --version
```

This should output something along the lines of the following:

```
git version 2.16.3 
```
Now that Git is working, we can clone the source code accompanying this book from GitHub. Execute the following command:

```
cd ~\DJK\
git init
git clone https://github.com/Fredy-SSA/DJK.git
```
This will clone the content of the master branch into your local folder, ~/DJK. This folder will now contain all of the sample solutions for the labs we are going to do together in this book. Refer to these sample solutions if you get stuck.

Now that we have installed the basics, let's continue with the code editor.