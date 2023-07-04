# Setting CI/CD for Angular Demo Application with Azure DevOps
## Abstract
Azure DevOps enables you to host, build, plan and test your code with complimentary workflows.
This document guides you to set up Infrastructure and start Continuous Integration and Continuous Deployment in Microsoft Azure using IAC and CI/CD pipelines.

## Prerequisites:
### 1. Setup Project in Azure DevOps
*   Create an organization in [Azure DevOps](https://dev.azure.com).

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/9a3998e6-d368-4841-9fa4-e69b3b77c496)

*   Then create a project inside that Azure DevOps organization.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/f4546a0b-61a0-49d1-9529-376e95c04f2f)

### 2. Create a Service Connection
Before you create the pipeline, you should first create a Service Connection since you will be asked to choose and verify your connection when creating your template. A Service Connection will allow you to connect to your Azure Subscription when using the task templates. You can create a new Service Connection. </br>

* Go to [Azure DevOps](https://dev.azure.com), navigate to ORGANIZATION NAME > PROJECTNAME >Project Settings > Service connections*
* Click Create service connection.
* Select Azure Resource Manager.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/9011a5fb-9d67-4f20-902b-1c447f221554)

* On next screen select Service principal (automatic). Select the proper subscription.
* Add name of service connection, check the security box and click save. 

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/9dddcba2-2ba4-4aa1-80c7-9671ae988505)

* #####  `Note:` While creating a service connection select Azure Resource Manager option. Also, skip the resource group field in the next tab.

### 3. Setup Project variables
* Create a variable group in Azure DevOps [pipeline library](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/variable-groups?view=azure-devops&tabs=classic). Add the following project variables:

  `SUBSCRIPTION_ID` </br> `RESOURCE_GROUP` </br> `LOCATION` </br> `AZURE_RM_SVC` </br> `AZURE_CONTAINER_REGISTRY` </br> `APP_SERVICE_NAME`  

* #### `Note:` AZURE_RM_SVC is name of the service connection you created in the previous step.

## Create the Prerequisite Pipeline
* To create a pipeline, On the left menu bar go to Pipelines and click the Create Pipeline button. The next screen will ask you where the code is to create the pipeline from, so choose  GitHub. It will ask for GitHub authorization. </br> 
* Complete the authorization then select your repository. As we want to first set up the environment (Resource Group, ACR, App Service) so we will choose the `Existing Azure Pipelines YAML file` that allows us to automatically create Resource Group, Container Registry, App Service. </br>

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/89a8b75f-815a-4573-9d47-d08db2400000)

* Select the branch and locate the IAC-pipeline.yml file.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/c1721ffe-33f4-4bb2-8224-e3a456491d3e)

* Now make sure to change the branch name as per your GitHub branch and variable group which you have created in earlier steps.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/030f1ebe-ec7a-4201-8a0c-f62f532229f8)

* Finally, save and run the pipeline. Check pipeline logs and permit for variable group access if asked. 

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/d39d3a84-5ad2-49b2-a5d7-3e71a40584fb)

* Once the IAC-pipeline run successfully, you can see the pipeline logs.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/8355d232-efe5-44c7-973d-7b5a576c47f4)

* Now verify the resources are created within a resource group by signing in [Azure Portal](https://portal.azure.com/#home). 
* Search Container Registry and select your container registry from the list. On left-hand menu select access keys then copy the `Password`. </br>

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/db57eb6f-aa9a-4904-8f1a-9f659e42a04c)

* Add a variable named `DOCKER_REGISTRY_SERVER_PASSWORD` in variable group (created in earlier steps) and save the copied password as value.

## Create the CI/CD Pipeline

Before we set up the continuous build and deploy (CI/CD pipeline) we will need to add the Azure Container Registry as a service connection in Azure DevOps. This service connection will be used in the build and deploy pipelines. Use the following steps to create container registry service connection: </br>

* Go to [Azure DevOps](https://dev.azure.com), navigate to ORGANIZATION NAME > PROJECTNAME >Project Settings > Service connections*
* Click Create service connection.
* Select Docker Registry.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/ba89b5f5-9128-4b00-a024-634ec773db23)

* On next screen select Azure Container Registry. Authentication Type as `Service Principal`, then choose your subscription, and the ACR you have created recently.
* Add name of service connection, check the security box and click save. 

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/85fc292e-6c48-4110-8d9e-496bcb925e3d)

* Now add a variable `ACR_SVC` having value as container registry service connection name (created in above step), in the previously created variable group.

* Now set up the CI/CD pipeline. On the left menu bar go to Pipelines and click the Create Pipeline button.
* The next screen will ask you where the code is to create the pipeline from, so choose  GitHub and select your repository. </br>
* Next choose the Existing Azure Pipelines YAML file option. Select the branch and locate the CI_CD pipeline.yml file. Now make sure to change the branch name as per your GitHub branch and variable group. Then save and run the pipeline.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/4f351e49-5878-45e6-bd65-e926c5efd609)

* From here you are ready to continuously build and deploy your application through Azure DevOps. You can verify pipeline runs and logs.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/4e43cd02-23f6-4499-aa99-3d912ad18589)

* Again permit the the pipeline if asked.
![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/6dd19d04-ce2a-4e4d-9d81-8df41a67321d)

* Once the CI CD pipeline run successfully you can see the following logs.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/43aba6a8-9052-4d42-a1da-0c476e022dad)

* Now you can explore the deployed application.

![image](https://github.com/ashwin-singh-21/angular-demo-app/assets/69102413/9b762a56-f63a-4f06-b4af-f9161d9af360)








