pipeline {
   agent any
   environment {
     HCLOUD_TOKEN = credentials('hcloud-token')
   }

   stages {
      stage('Lint Code') {
         steps {
            sh 'ansible-lint setup-tomcat.yml'
         }
      }

      stage('Prepare test environment') {
         steps {
            sh 'terraform init'
            sh 'terraform apply -auto-approve -var="hcloud_token=${HCLOUD_TOKEN}"'
         }
      }

      stage('Run Playbooks') {
         steps {
            sh 'ansible-playbook -i inventory/test.hcloud.yml setup-tomcat.yml'
         }
      }

      stage('Run Tests') {
         steps {
            sh 'py.test --connection=ansible --ansible-inventory=inventory/test.hcloud.yml --force-ansible -v tests/*.py'
         }
      }
   }

   post {
       always {
           sh 'terraform destroy -auto-approve -var="hcloud_token=${HCLOUD_TOKEN}"'
       }
   }
}
