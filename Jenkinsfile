import groovy.json.*

@Library('jenkins-pipeline-library') _

pipeline {

    agent { node "flutter" }

    options {
        timestamps()
        disableConcurrentBuilds()
        skipDefaultCheckout true
        timeout(time: 60, unit: 'MINUTES')
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    triggers {
        gitlab(
          triggerOnPush: true
          , triggerOnMergeRequest: false
          , branchFilterType: "NameBasedFilter"
          , includeBranchesSpec: "main"
          , secretToken: "z0oevol40mkos6vyfum2tibrtz9ame79d"
        )
    }

    environment {
        FIREBASE_TOKEN = credentials('FIREBASE_TOKEN')
        CompanyName = "techx"
        ProjectName = "ota"
        PackageName = "scb-ota-app"
        GitURL = "https://gitlab.devops.easy2easiest.com"
        GitCredentials = "gitlab-easy2easiest"
        GitCloudURL = "https://gitlab.com/scbtechx"
        GitCloudCredentials = "gitlab-scbtechx"
        ProjectMetadataGitRepo = "https://gitlab.devops.easy2easiest.com/xplatform/devops-pipelines/projects-metadata.git"
    }

    stages{
        stage('Git Checkout') {
            when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
            steps {
                script {
                    sh '''
                        pwd
                        cd $workspace
                        ls -ll
                        rm -rf *
                        ls -ll

                    '''
                    def setEnvironmentInformation = new com.library.SetEnvironmentInformation()

                    dir("projects-metadata") {
                        sh "git config --global --unset credential.helper ||true"
                        libGitCheckout(
                            url: env.ProjectMetadataGitRepo
                            , branch: "master"
                            , credentials: env.GitCredentials
                        )

                        if (fileExists("${env.CompanyName}/${env.ProjectName}/project_information.json")) {
                            setEnvironmentInformation.execute (
                                variableName: "ProjectInformation"
                                , filePath: "${env.CompanyName}/${env.ProjectName}/project_information.json"
                            )
                            def projectInformationJson = readJSON text: env.ProjectInformation
                            env.GitlabBranchDefault = projectInformationJson["branch_default"]
                            env.GitlabXPlatformBranch = projectInformationJson["git_xplatform_branch"]
                        } else {
                            echo "\033[1;31m *** project_information.json file not found, please contact Digital DevOps *** \033[0m"
                            error "fail"
                        }

                        if (fileExists("${env.CompanyName}/${env.ProjectName}/${env.PackageName}/service_information.json")) {
                            setEnvironmentInformation.execute (
                                variableName: "ServiceInformation"
                                , filePath: "${env.CompanyName}/${env.ProjectName}/${env.PackageName}/service_information.json"
                            )

                            def serviceInformationJson = readJSON text: env.ServiceInformation
                            env.ServiceTemplateName = serviceInformationJson["service_info"].template_name
                            env.GitSourceCodeUrl = serviceInformationJson["gitlab_repo"].url
                        } else {
                            echo "\033[1;31m *** service_information.json file not found, please contact Digital DevOps *** \033[0m"
                            error "fail"
                        }
                    }

                    dir("source") {
                        sh "git config --global --unset credential.helper ||true"
                        libGitCheckout(
                            url: env.GitSourceCodeUrl,
                            branch: "$env.BRANCH_NAME",
                            credentials: env.GitCloudCredentials
                        )
                    }
                }
            }
        }
        
 /*   stage('Run Trufflehog') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            dir ("source") {
                sh """
                    pip3 install truffleHog
                    truffleHog ${env.GitSourceCodeUrl} --regex --json > trufflehog.txt || exit 0
                """
            }
        }
    } */

    stage('Flutter Clean') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            dir ("source") {
                sh "flutter clean"
            }
        }
    }

/*    stage('Upload Sonarqube') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        environment {
            SONARQUBE_URL = "https://sonar-internal.np.aella.tech"
            SONARQUBE_TOKEN = credentials('aella-sonarqube')
        }
        steps {
            script {
                dir("source") {
                    def scannerHome = tool 'SonarScanner';
                    withSonarQubeEnv(credentialsId: 'aella-sonarqube') {
                        sh """
                            ${scannerHome}/bin/sonar-scanner --version
                            echo 'Upload Sonarqube'
                            ${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=scb:flutter-demo -Dsonar.sources=lib -Dsonar.host.url=$SONARQUBE_URL -Dsonar.login=$SONARQUBE_TOKEN -X
                        """
                    }
                }
            }
        }
    } */

    stage('Update Package Version') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            script {
                dir("source") {
                    sh '''
                        if [ $BRANCH_NAME = develop || main ];  
                        then
                        perl -i -pe 's/^(version:\\s+\\d+\\.\\d+\\.\\d+\\+)(\\d+)$/$1.($2+1)/e' pubspec.yaml
                        else
                        echo "package version is not updated"
                        fi
                    '''
                } 
            }     
        }
    }

    stage('Flutter Analyze') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            dir("source"){
                sh "flutter analyze"
            }
        }
    }

    stage('Prepare Config') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            echo "Hello World // maybe may have config in the future."
        }
    }
    
    stage('Unit Tests') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            dir("source") {
                sh '''
                    if [ $BRANCH_NAME = develop ]; 
                    then 
                    flutter test --coverage; 
                    else 
                    flutter test; 
                    fi
                '''
            }
        }
    }

    stage('Build Android distribute') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            script {
                dir("source") {
                    sh """
                        ls -ll
                        pwd
                        cd android
                        bundle install
                        flutter doctor
                        flutter clean
                        flutter pub get
                        flutter pub upgrade
                        flutter build apk --flavor dev --dart-define=ENV_TYPE=dev --dart-define=GRAPHQL_BASE_URL=https://ota-api-interface-dev.np.scbtechx.io --profile
                    """
                                
                    dir('android') {
                        sh """
                            ls -ltr
                            bundle install
                            bundle update fastlane
                            gem install fastlane-plugin-firebase_app_distribution
                            bundle exec fastlane distribute_firebase firebase_cli_token:${FIREBASE_TOKEN}
                        """
                    }
                }
            }
        }
    }
 /*   stage('Build ios') {
          steps {
                  script {
                      dir('ios') {
                        sh '''
                           rm -rf flutt*
            curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_2.5.2-stable.zip
             unzip flutter_macos_2.5.2-stable.zip
             ls -la
             export PATH="$PATH:`pwd`/flutter/bin"
             export GEM_HOME=/Users/jenkins/.gem
             export PATH=\$GEM_HOME/ruby/2.7.0/bin:\$PATH
             cd $WORKSPACE
             ls -ll
             cd source
             ls -ll
             cd ios
             flutter clean
             flutter pub get
             pwd
             ls -ll
                        pod install
                        pod repo update
                        pod update
                        bundle install
                        bundle update
                        gem install bundler:2.2.29
                        flutter doctor
                        rm -rf Podfile
                        flutter pub upgrade
                        ls -ll
                        flutter build ios --dart-define=ENV_TYPE=$DEPLOYMENT_ENV --dart-define=GRAPHQL_BASE_URL="{$GRAPHQL_URL}" --release --flavor $DEPLOYMENT_ENV
                        xcodebuild clean archive -workspace Runner.xcworkspace -scheme $DEPLOYMENT_ENV -archivePath RunnerArchive
                        xcodebuild -exportArchive -archivePath RunnerArchive.xcarchive -exportOptionsPlist Environments/$DEPLOYMENT_ENV/ExportOptions.plist -exportPath ./build
                        ls -ll 
                      '''
             }
          }
      }
    } */

 /*   stage ('Distribute Packaged') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            script {
                parallel(
                    "iOS" : {
                        dir('source/ios') {
                            def esCredential = "flutter_firebase_cli_token"
                            withCredentials([string(credentialsId: 'flutter_firebase_cli_token', variable: 'flutter_firebase_cli_token')]) {
                                sh "bundle exec fastlane distribute firebase_cli_token:${flutter_firebase_cli_token}"
                                echo 'IOS Distributed to Firebase successfully'
                            }
                        }
                    },  
                    "Android" : {
                        dir('source/android') {
                            def esCredential = "flutter_firebase_cli_token"
                            withCredentials([string(credentialsId: 'flutter_firebase_cli_token', variable: 'flutter_firebase_cli_token')]) {
                               sh '''
                                gem install fastlane-plugin-firebase_app_distribution
                                bundle exec fastlane distribute_firebase firebase_cli_token:${FIREBASE_TOKEN}
                                echo 'Android Distributed to Firebase successfully'
                                '''
                            }
                        }
                    }
                )
            }
        }      
    } */
/*    stage('Bump Package Version') {
        when { expression { !clarifyPipelineTriggerToReloadNewConfig() } }
        steps {
            script {
                dir ("source") {
                    withCredentials([usernamePassword(credentialsId: env.GitCloudCredentials, passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh("""
                            git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
                            bundle install
                            bundle update fastlane
                            bundle exec fastlane bump_version_to_git branch_name:${env.GitlabBranchDefault}
                        """)
                    }
                }
            }
        }
    } */

 /*   stage('Preparation DeviceFarm Config') {
            steps {
                    sh "aws configure set default.region us-west-2"
                    sh "aws configure list"
                  }
        }

    stage('Deploy to AWS DeviceFarm') {
            steps {
                    script {
                            parallel(
                                    "Android" : {
                                       PROJECT_ARN_ANDROID = sh (
                                       script: "aws devicefarm list-projects --query 'projects[?name==`scb-xplatform-android`].arn' --output text",
                                       returnStdout: true).trim()
                                       print "DEBUG: ${PROJECT_ARN_ANDROID}"
          
                                       // upload app.apk
                                       sh "aws devicefarm create-upload \
                                       --project-arn '${PROJECT_ARN_ANDROID}' \
                                       --name app-release.apk \
                                       --type ANDROID_APP > uploadAppOutput-android.json"
                                       def APP_UPLOAD_OUTPUT = readJSON file:'uploadAppOutput-android.json'
                                       def APP_UPLOAD_URL = APP_UPLOAD_OUTPUT.upload.url
                                       APP_ARN_ANDROID = APP_UPLOAD_OUTPUT.upload.arn
                                       echo "APP_ARN_ANDROID : ${APP_ARN_ANDROID}"
                                       
                                       // Push .apk
                                       sh "curl -T ${WORKSPACE}/build/app/outputs/apk/release/app-release.apk '${APP_UPLOAD_URL}'"
                                       sh "aws devicefarm get-upload --arn ${APP_ARN_ANDROID} > getUploadAppOutput-android.json"
                                       def CHECK_APP_UPLOAD_OUTPUT = readJSON file:'getUploadAppOutput-android.json'
                                       def CHECK_APP_UPLOAD = APP_UPLOAD_OUTPUT.upload.status
                                       echo "CHECK_STATUS_UPLOAD : ${CHECK_APP_UPLOAD}"
                                    },

                                    "IOS" : {
                                       PROJECT_ARN_IOS = sh (
                                       script: "aws devicefarm list-projects --query 'projects[?name==`scb-xplatform-ios`].arn' --output text",
                                       returnStdout: true).trim()
                                       print "DEBUG: ${PROJECT_ARN_IOS}"
          
                                       // upload app.ipa
                                       sh "aws devicefarm create-upload \
                                       --project-arn '${PROJECT_ARN_IOS}' \
                                       --name app-release.ipa \
                                       --type IOS_APP > uploadAppOutput-ios.json"
                                       def APP_UPLOAD_OUTPUT = readJSON file:'uploadAppOutput-ios.json'
                                       def APP_UPLOAD_URL = APP_UPLOAD_OUTPUT.upload.url
                                       APP_ARN_IOS = APP_UPLOAD_OUTPUT.upload.arn
                                       echo "APP_ARN_IOS : ${APP_ARN_IOS}"
                                       
                                       // Push .ipa
                                       sh "curl -T ${WORKSPACE}/ios/my-app-1.ipa '${APP_UPLOAD_URL}'"
                                       sh "aws devicefarm get-upload --arn ${APP_ARN_IOS} > getUploadAppOutput-ios.json"
                                       def CHECK_APP_UPLOAD_OUTPUT = readJSON file:'getUploadAppOutput-ios.json'
                                       def CHECK_APP_UPLOAD = APP_UPLOAD_OUTPUT.upload.status
                                       echo "CHECK_STATUS_UPLOAD : ${CHECK_APP_UPLOAD}"
                                    }                               
                    )
                }
             }
         } 

    stage('Run Test on AWS Device Farm') {
        steps {
                script {
                         parallel(
                                    "Android" : {
                                        DEVICE_POOL_ANDROID = sh (
                                        script: "aws devicefarm list-device-pools --arn '${PROJECT_ARN_ANDROID}' --query 'devicePools[?name==`samsung-galaxy-s9`].arn' --output text",
                                        returnStdout: true).trim()
                    
                                        RUN_ARN_ANDROID = sh (
                                            script: "aws devicefarm schedule-run \
                                            --project-arn '${PROJECT_ARN_ANDROID}' \
                                            --app-arn '${APP_ARN_ANDROID}' \
                                            --device-pool-arn '${DEVICE_POOL_ANDROID}' \
                                            --test type=BUILTIN_FUZZ \
                                            --name 'test-demo-apps' \
                                            --query 'run.arn' --output text",
                                            returnStdout: true).trim()
                    
                                            def keepRunning = true
                                            while(keepRunning){ 
                                                
                                                sleep(60)
                                    
                                                RUN_STATUS = sh (
                                                    script: "aws devicefarm get-run --arn '${RUN_ARN_ANDROID}' --query 'run.status' --output text",
                                                    returnStdout: true
                                                ).trim()
                                    
                                                if (RUN_STATUS == "COMPLETED"){
                                                    println "COMPLETED ANDROID"
                                                    keepRunning = false
                                                }
                                            }  
                                            print "TestStatus: ${RUN_STATUS}"
                                    },

                                    "ios" : {
                                        DEVICE_POOL_IOS = sh (
                                        script: "aws devicefarm list-device-pools --arn '${PROJECT_ARN_IOS}' --query 'devicePools[?name==`iphone-12`].arn' --output text",
                                        returnStdout: true).trim()
                    
                                        RUN_ARN_IOS = sh (
                                            script: "aws devicefarm schedule-run \
                                            --project-arn '${PROJECT_ARN_IOS}' \
                                            --app-arn '${APP_ARN_IOS}' \
                                            --device-pool-arn '${DEVICE_POOL_IOS}' \
                                            --test type=BUILTIN_FUZZ \
                                            --name 'test-demo-apps' \
                                            --query 'run.arn' --output text",
                                            returnStdout: true).trim()
                    
                                            def keepRunning = true
                                            while(keepRunning){ 
                                                
                                                sleep(1)
                                    
                                                RUN_STATUS = sh (
                                                    script: "aws devicefarm get-run --arn '${RUN_ARN_IOS}' --query 'run.status' --output text",
                                                    returnStdout: true
                                                ).trim()
                                    
                                                if (RUN_STATUS == "COMPLETED"){
                                                    println "COMPLETED IOS"
                                                    keepRunning = false
                                                }
                                            }  
                                            print "TestStatus: ${RUN_STATUS}"
                                    }
               
                    )
                }
            }
        }*/
    }

    post {
        always {
            script {
                step([$class: "WsCleanup"])
            }
        }
        success {
            echo 'Job Success'
        }
        unstable {
            echo 'Job Unstable'
        }
        failure {
            echo 'Job Failure'
        }
    }
}
