job("1 Git Pull") {
  description("Pulls Code From GitHub Repository")  
  
  scm {
    github("1398abhisingh911/tasksec", "master") 
  }

  triggers {
    githubPush()
  }
}

job("2 Check And Deploy") {
  description("Check")
  
  triggers {
    upstream("1 Git Pull")
  }

  steps {
    shell(readFileFromWorkspace("deploy.sh"))
  }
}

job("3 Test App") {
  description("Testing")
  
  triggers {
    upstream("2 Check And Deploy")
  }

  steps {
    shell(readFileFromWorkspace("testing.sh"))
  }
}

job("4 Send Mail") {
  description("If site Not Working Send Mail to Developer ")
  
  triggers {
    upstream("3 Test App")
  }

  publishers {
        mailer('1398abhisingh911@gmail.com')
  }
}

buildPipelineView("K8s Deploy WebApp") {
  title("k8s job")
  description("Code done")
  selectedJob("1 Git Pull")
  alwaysAllowManualTrigger(true)
  refreshFrequency(3)
  displayedBuilds(1)
  showPipelineParameters(true)
}
