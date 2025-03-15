pipeline {
    agent any

    stages {
//         stage('Checkout') {
//             steps {
//             checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SSPRI/demoec2.git']]])            

//           }
//         }
        
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve') 
           }
        }
    }
}



//            stage ("terraform Action") {
//              steps {
//                  script {
//                      echo "Terraform action is --> ${action}"
//                      def action = '${action}'
//                      if (action) {
//                          sh ('terraform ${action}')
//                      }
//                      else {
//                         sh ('terraform ${action} -auto-approve') 
//                      }
//            }
//         }
//            }

        
//     }
// }
