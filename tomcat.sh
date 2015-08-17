Change to the /etc/init.d directory and create a script called 'tomcat' as shown below.

view plaincopy to clipboardprint?

    [root@blanche share]# cd /etc/init.d  
    [root@blanche init.d]# vi tomcat  



view plaincopy to clipboardprint?

    #!/bin/bash  
    # description: Tomcat Start Stop Restart  
    # processname: tomcat  
    # chkconfig: 234 20 80  
    JAVA_HOME=/usr/java/jdk1.6.0_24  
    export JAVA_HOME  
    PATH=$JAVA_HOME/bin:$PATH  
    export PATH  
    CATALINA_HOME=/usr/share/apache-tomcat-6.0.32  
      
    case $1 in  
    start)  
    sh $CATALINA_HOME/bin/startup.sh  
    ;;   
    stop)     
    sh $CATALINA_HOME/bin/shutdown.sh  
    ;;   
    restart)  
    sh $CATALINA_HOME/bin/shutdown.sh  
    sh $CATALINA_HOME/bin/startup.sh  
    ;;   
    esac      
    exit 0  
