pipeline {
agent none
node {
  git branch: ‘master’, url: ‘https://github.com/ankababug/jen-trfm.git’
  stage('init') {
    sh label: 'Initialize Terraform', script: "/usr/bin/terraform init"
  }
  stage('plan') {
    sh label: 'Plan Terraform', script: "/usr/bin/terraform plan -out=plan"
    script {
        timeout(time: 10, unit: 'MINUTES') {
          input(id: "Deploy Gate", message: "Deploy environment?", ok: 'Deploy')
        }
    }
  }
  stage('apply') {
    sh label: 'Deploy Infrastructure', script: "/usr/bin/terraform apply plan"
  }
 }

post {
  always {
    cleanWs()
   }
  }
