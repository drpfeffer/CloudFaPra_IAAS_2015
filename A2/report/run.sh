#!/usr/bin/env bash

# MySQL-Server
echo "Creating MySQL-Server:"
knife ec2 server create --groups=sshmysql | tee createsql.tmp
sqlIP=$(grep "Public DNS Name:" createsql.tmp | tail -1)
sqlIP=${sqlIP#*:}
sqlIP=\${sqlIP#*:}
rm createsql.tmp
knife solo prepare ubuntu@$(echo $sqlIP)
cp nodes/mysql.json nodes/$(echo $sqlIP).json
knife solo cook ubuntu@$(echo $sqlIP)
scp -i ~/.ssh/cloudfapra.pem helpers/my.cnf ubuntu@$(echo $sqlIP):.my.cnf
scp -i ~/.ssh/cloudfapra.pem helpers/flush.sql ubuntu@$(echo $sqlIP):.
ssh -i ~/.ssh/cloudfapra.pem ubuntu@$(echo $sqlIP) 'mysql<flush.sql;rm flush.sql .my.cnf'
echo "MySQL-Server ready and running."

# WordPress-Server
echo "Creating WordPress-Server:"
knife ec2 server create --groups=sshhttphttps | tee createwp.tmp
wpIP=$(grep "Public DNS Name:" createwp.tmp | tail -1)
wpIP=${wpIP#*:}
wpIP=${wpIP#*:}
rm createwp.tmp
knife solo prepare ubuntu@$(echo $wpIP)
cp nodes/wpnosql.json nodes/$(echo $wpIP).json
sed -i "s/MYSQLSERVER/$(echo $sqlIP)/g" nodes/$(echo $wpIP).json
knife solo cook ubuntu@$(echo $wpIP)
echo "WordPress-Server ready and running."
echo "All done. Your WordPress-Instance: $wpIP"
