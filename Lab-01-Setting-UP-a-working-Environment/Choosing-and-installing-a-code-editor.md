# Choosing a code editor
Using a good code editor is essential to working productively with Docker. Of course, which editor is the best is highly controversial and depends on your personal preference. A lot of people use Vim, or others such as Emacs, Atom, Sublime, or **Visual Studio Code (VS Code)**, to just name a few. VS Code is a completely free and lightweight editor, yet it is very powerful and is available for macOS, Windows, and Linux. According to Stack Overflow, it is currently by far the most popular code editor. If you are not yet sold on another editor, I highly recommend that you give VS Code a try.

But if you already have a favorite code editor, then please continue using it. As long as you can edit text files, you're good to go. If your editor supports syntax highlighting for Dockerfiles and JSON and YAML files, then even better. The only exception will be  Debugging Code Running in a Container. The examples presented in that chapter will be heavily tailored toward VS Code. 

# Installing VS Code on macOS
Follow these steps for installation:

Open a new Terminal window and execute the following command:
```
$ brew cask install visual-studio-code
```
Once VS Code has been installed successfully, navigate to your home directory (~) and create a folder, DJK; then navigate into this new folder:
```
$ mkdir ~/DJK && cd ~/DJK
```
Now open VS Code from within this folder:
```
$ code .
```
Don't forget the period (.) in the preceding command. VS will start and open the current folder (~/DJK) as the working folder.

# Installing VS Code on Windows
Follow these steps for installation:

Open a new PowerShell window in admin mode and execute the following command:
```
PS> choco install vscode -y
```
Close your PowerShell window and open a new one, to make sure VS Code is in your path.
Now navigate to your home directory and create a folder, **DJK**; then navigate into this new folder:
```
PS> mkdir ~\DJK; cd ~\DJK
```
Finally open Visual Studio Code from within this folder:
```
PS> code .
```
Don't forget the period (.) in the preceding command. VS will start and open the current folder (**~\DJK**) as the working folder.

# Installing VS Code on Linux
Follow these steps for installation:

On your Debian or Ubuntu-based Linux machine, open a Bash Terminal and execute the following statement to install VS Code:
```
$ sudo snap install --classic code
```
- If you're using a Linux distribution that's not based on Debian or Ubuntu, then please follow the following link for more details: https://code.visualstudio.com/docs/setup/linux
- Once VS Code has been installed successfully, navigate to your home directory (~) and create a folder, **DJK**; then navigate into this new folder:
```
$ mkdir ~/DJK && cd ~/DJK
```
Now open Visual Studio Code from within this folder:
```
$ code .
```
Don't forget the period (.) in the preceding command. VS will start and open the current folder (~/DJK) as the working folder.

# Installing VS Code extensions
Extensions are what make VS Code such a versatile editor. On all three platforms, macOS, Windows, and Linux, you can install VS Code extensions the same way:

Open a Bash console (or PowerShell in Windows) and execute the following group of commands to install the most essential extensions we are going to use in the upcoming examples in this book:

```
code --install-extension vscjava.vscode-java-pack
code --install-extension ms-vscode.csharp
code --install-extension docsmsft.docs-markdown
code --install-extension ms-vscode.PowerShell
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
```

- We are installing extensions that enable us to work with Java, C#, .NET, and Python much more productively. We're also installing an extension built to enhance our experience with Docker.

- After the preceding extensions have been installed successfully, restart VS Code to activate the extensions. You can now click the extensions icon in the activity pane on the left-hand side of VS Code to see all of the installed extensions.
Next, let's install Docker for Desktop.