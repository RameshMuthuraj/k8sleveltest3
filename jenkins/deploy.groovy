node {
   def testdeploy
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/kubernetes/examples.git'
      
   }
   stage('Deploy Code') {
      withEnv(["MVN_HOME=$mvnHome"]) {
         if (isUnix()) {
            sh 'kubectl apply -f ./ -n kube-system --kubeconfig /var/lib/jenkins/config'
         } else {
            bat("echo 'windows build not supported'" )
         }
      }
   }
   stage('Results') {
      sh "echo done"
   }
}
