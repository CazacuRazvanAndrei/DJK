
az configure --defaults acr=testmachine
az login

az acr login


docker run -it --rm `
    --volumes-from some-wordpress `
    --network container:some-wordpress `
    wordpress:cli user list

# https://markheath.net/post/wordpress-container-app-service

# create a resource group to hold everything in this demo
$resourceGroup = "AzDocker"
$location = "northeurope"
az group create -l $location -n $resourceGroup

# create an app service plan to host our web app
$planName="azdocker"
az appservice plan create -n $planName -g $resourceGroup `
                          -l $location --is-linux --sku S1 

# we need a unique name for the servwer
$mysqlServerName = "mysql-name"
$adminUser = "wpadmin"
$adminPassword = "Pass"

az mysql server create -g $resourceGroup -n $mysqlServerName `
            --admin-user $adminUser --admin-password "$adminPassword" `
            -l $location `
            --ssl-enforcement Disabled `
            --sku-name GP_Gen5_2 --version 5.7

# open the firewall (use 0.0.0.0 to allow all Azure traffic for now)
az mysql server firewall-rule create -g $resourceGroup `
--server $mysqlServerName --name AllowAppService `
--start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

# Create a Web App from a Container
$appName="zizo"
az webapp create -n $appName -g $resourceGroup `
                 --plan $planName -i "wordpress"

# Configure the Environment Variables
# get hold of the wordpress DB host name
$wordpressDbHost = (az mysql server show -g $resourceGroup -n $mysqlServerName `
                   --query "fullyQualifiedDomainName" -o tsv)

# configure web app settings (container environment variables)
az webapp config appsettings set `
    -n $appName -g $resourceGroup --settings `
    WORDPRESS_DB_HOST=$wordpressDbHost `
    WORDPRESS_DB_USER="$adminUser@$mysqlServerName" `
    WORDPRESS_DB_PASSWORD="$adminPassword"

#Test It
$site = az webapp show -n $appName -g $resourceGroup `
                       --query "defaultHostName" -o tsv
Start-Process https://$site