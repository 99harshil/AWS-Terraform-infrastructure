pipeline 
{
  agent any
   
  parameters 
  {
    choice(
	choices: ['apply', 'destroy'],
        description: 'Terraform action to apply or destroy',
        name: 'action'
    )
    
    checkboxParameter(
	name: 'Modules', 
	format: 'JSON',
        pipelineSubmitContent: '{"CheckboxParameter": [{"key": "VPC","value": "vpc"},
						       {"key": "Credstash","value": "credstash"},
						       {"key": "EC2 Instance","value": "ec2"}]}', 
	description: 'AWS modules to deploy or destroy')
  }
  
  stages 
  {   
    stage('Checkout') 
    {
        steps {
            git branch: 'master',
                credentialsId: 'my_cred_id',
                url: 'https://github.com/99harshil/AWS-Terraform-infrastructure.git'
            sh "ls"
        }
    }
    stage('apply') 
    {
        when 
	{ 
            expression { params.action == 'apply' }
        }
        steps 
    	{
            	dir('terraform/backend') 
		{
                	withAWS(credentials: '493d0f87-10d7-4be2-9108-f18321145beb', region: 'us-east-1') 
			{
                    		sh 'terraform init -upgrade'
	            		sh 'terraform plan'
                    		sh 'terraform apply -auto-approve'
            		}
		}
            	script
		{
			def apply_list = params.Modules.split(',')
			for (int i = 0; i < apply_list.size(); ++i)  
			{
                		echo "Running Terraform in ${apply_list[i]}"
                		if (apply_list[i] == "vpc") 
				{
					sh 'echo "in nested if condition"'
                    			dir('terraform/deployments/'+apply_list[i]) 
					{
						withAWS(credentials: '493d0f87-10d7-4be2-9108-f18321145beb', region: 'us-east-1') 
						{
					    		sh 'pwd'
                        				sh 'terraform init -upgrade'
                        				sh 'terraform plan -target="module.vpc.aws_vpc.vpc" -target="module.vpc.aws_subnet.public_subnet" -target="module.vpc.aws_subnet.private_subnet" -out=tfplan'
                        				sh 'terraform apply -auto-approve tfplan'
							sh 'terraform plan -out=tfplan2'
							sh 'terraform apply -auto-approve tfplan2'
                    				}
					}
                		}			
                		else 
				{
					sh 'echo "in else condition"'
					dir('terraform/deployments/'+apply_list[i])
					{
						withAWS(credentials: '493d0f87-10d7-4be2-9108-f18321145beb', region: 'us-east-1')
                                                {
                                                        sh 'terraform plan -out=tfplan'
							sh 'terraform apply -auto-approve tfplan'
						}
					}
                    		}
            		}
          	}
       	}
    }
    
    stage('destroy')
    {
    	when
        {
        	expression { params.action == 'destroy' }
        }
	steps
	{
		script
		{
			def destroy_list = params.Modules.split(',')
			for (int i = destroy_list.size() - 1; i >= 0; i--)
			{
				echo "Running Terraform in ${destroy_list[i]}"
				dir('terraform/deployments/'+destroy_list[i])
				{
					withAWS(credentials: '493d0f87-10d7-4be2-9108-f18321145beb', region: 'us-east-1')
					{
						sh 'terraform init -upgrade'
						sh 'terraform destroy -auto-approve'
					}
				}
			}
		}
		dir('terraform/backend')
		{
			withAWS(credentials: '493d0f87-10d7-4be2-9108-f18321145beb', region: 'us-east-1')
			{
				sh 'terraform init -upgrade'
				sh 'terraform destroy -auto-approve'
			}
		}		
	}
    }
  }
}
