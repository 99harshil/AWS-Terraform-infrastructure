#!/bin/bash

# "key-pair" "ec2-instance" "security-group" "classic-load-balancer" "rds"
# "rds" "classic-load-balancer" "security-group" "ec2-instance" "key-pair" 

deploy_infrastructure=( "vpc" "credstash" )
destroy_infrastructure=( "credstash" "vpc" )

# Call 'terraform backend' for a directory
tf_backend() {
	directory="${1}"
    	var_file="${2}"
        cd ./$directory

	echo -e "\n\n backend is creating \n\n"
	if [ -z "${directory}" ]; then
		echo 'Unspecified directory.'
		return 1
	fi

	if [ -z "${var_file}" ]; then
		var_file='terraform.tfvars'
    	fi

	if [ -e "${var_file}" ] || [ -e "${directory}/${var_file}" ]; then
        	"${TERRAFORM}"            \
            		init                  \
            		-input=false          \
            		-upgrade=true

		"${TERRAFORM}"            \
                        plan                  \
                        -input=false          \
                        -out="${plan_file}"

		"${TERRAFORM}"            \
                        apply                 \
                        -auto-approve         \
                        -input=false          \
		"${plan_file}"
    	else
        		"${TERRAFORM}"            \
            		init                  \
            		-input=false          \
            		-upgrade=true

		"${TERRAFORM}"            \
                        plan                  \
                        -input=false          \
                        -out="${plan_file}"

		"${TERRAFORM}"            \
                        apply                 \
                        -auto-approve         \
                        -input=false          \
		"${plan_file}"
    	fi
        cd ..
}

# Call 'terraform backend destroy' for a directory
tf_backend_destroy() {
	directory="${1}"
    	var_file="${2}"
        	cd ./$directory
        
	echo -e "\n\n backend is destroying\n\n"
	if [ -z "${directory}" ]; then
		echo 'Unspecified directory.'
		return 1
	fi
        
	if [ -z "${var_file}" ]; then
		var_file='terraform.tfvars'
    	fi

	if [ -e "${var_file}" ] || [ -e "${directory}/${var_file}" ]; then
        		"${TERRAFORM}"            \
            		init                  \
            		-input=false          \
            		-upgrade=true
 
		"${TERRAFORM}"              \
        	             destroy              \
		-auto-approve

    	else
        		"${TERRAFORM}"            \
            		init                  \
            		-input=false          \
            		-upgrade=true
 
		"${TERRAFORM}"              \
        	             destroy              \
		-auto-approve
    	fi
             cd .. 
}

# Call 'terraform init' for a directory
tf_init() {
    directory="${1}"
    var_file="${2}"
    cd ./$directory
    for dir1 in ${deploy_infrastructure[@]}; do
       	cd ./$dir1
	echo -e "\n\n"$dir1 "is initializing\n\n"
  	if [ -z "${dir1}" ]; then
		echo 'Unspecified directory.'
		return 1
	fi

	if [ -z "${var_file}" ]; then
		var_file='terraform.tfvars'
    	fi

	if [ -z "${backend_file}" ]; then
                backend_file='backend.conf'
        fi

	if [ -e "${var_file}" ] || [ -e "${dir1}/${var_file}" ]; then
        	"${TERRAFORM}"                    \
        	init                          \
		-backend-config="${backend_file}" \
		-reconfigure                  \
        	-input=false                  \
        	-upgrade=true

	elif [ -e "${backend_file}" ] || [ -e "${dir1}/${backend_file}" ]; then
		"${TERRAFORM}"                    \
                init                          \
                -reconfigure                  \
                -backend-config="${backend_file}" \
                -input=false                  \
                -upgrade=true

        elif [[ -e "${backend_file}" && -e "${var_file}" ]] || [[ -e "${dir1}/${var_file}" && -e "${dir1}/${backend_file}" ]]; then
		"${TERRAFORM}"                    \
                init                          \
                -reconfigure                  \
		-backend-config="${backend_file}" \
                -input=false                  \
                -upgrade=true

	else
            	"${TERRAFORM}"            \
        	init                  \
		-reconfigure          \
            	-input=false          \
            	-upgrade=true
    	fi
    cd ..
    done
}

# Call 'terraform deploy' for a directory
tf_deploy() {
  	  directory="${1}"
   	 var_file="${2}"
    	cd ./$directory
    	for dir1 in ${deploy_infrastructure[@]}; do
        	cd ./$dir1
		echo -e "\n\n"$dir1 "is creating\n\n"
        	if [ "vpc" == "${dir1}" ]; then
        		if [ -z "${dir1}" ]; then
        			echo 'Unspecified directory.'
        			return 1
    			fi

 			"${TERRAFORM}"            \
        	        plan                  \
			-input=false          \
                       	-target="module.vpc.aws_vpc.vpc"          \
	             	-target="module.vpc.aws_subnet.public_subnet"          \
        	      	-target="module.vpc.aws_subnet.private_subnet"          
	
			"${TERRAFORM}"            \
               	       	apply                 \
			-auto-approve         \
			-input=false          \
			-target="module.vpc.aws_vpc.vpc"          \
			-target="module.vpc.aws_subnet.public_subnet"          \
                        -target="module.vpc.aws_subnet.private_subnet"          

			"${TERRAFORM}"            \
			plan                  \
			-input=false          \
			-out="${plan_file}"

			"${TERRAFORM}"            \
			apply                 \
                        -auto-approve         \
			-input=false          \
			"${plan_file}"

    		else
			if [ -z "${dir1}" ]; then
       				echo 'Unspecified directory.'
       				return 1
  			fi

			"${TERRAFORM}"            \
			plan                  \
			-input=false          \
			-out="${plan_file}"

			"${TERRAFORM}"            \
			apply                 \
			-auto-approve         \
			-input=false          \
			"${plan_file}"
		fi		
    cd ..
    done
}

# Call 'terraform destroy' for a directory
tf_destroy() {
    	directory="${1}"
    	var_file="${2}"
    	cd ./$directory

    	for dir1 in ${destroy_infrastructure[@]}; do
      		cd ./$dir1
		echo -e "\n\n"$dir1 "is destroying\n\n"

		if [ "vpc" == "${dir1}" ]; then
        		if [ -z "${dir1}" ]; then
        			echo 'Unspecified directory.'
        			return 1
    			fi

    			if [ -z "${var_file}" ]; then
        			var_file='terraform.tfvars'
    			fi

                	if [ -e "${var_file}" ] || [ -e "${directory}/${var_file}" ]; then
                    		"${TERRAFORM}"              \
        	      		destroy              \
				-auto-approve

  			else
 				"${TERRAFORM}"              \
        	      		destroy              \
				-auto-approve
 			fi
		else
			if [ -z "${dir1}" ]; then
        			echo 'Unspecified directory.'
        			return 1
    			fi

    			if [ -z "${var_file}" ]; then
        			var_file='terraform.tfvars'
    			fi

    			if [ -e "${var_file}" ] || [ -e "${directory}/${var_file}" ]; then
                       		"${TERRAFORM}"              \
        	      		destroy              \
				-auto-approve
              	  	else
                		"${TERRAFORM}"              \
        	        	destroy              \
				-auto-approve
			fi
		fi
	cd ..
	done
}

if [ -z "${TERRAFORM}" ]; then
    TERRAFORM='terraform'
fi

action="${1}"
directory="${2}"
"tf_${action}" "${directory}" "${3}" "${4}"
