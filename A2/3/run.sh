#!/usr/bin/env bash

# WordPress-Server
echo "Creating WordPress-Server:"
knife ec2 server create --groups=sshhttphttps | tee createwp.tmp
wpIP=$(grep "Public DNS Name:" createwp.tmp | tail -1)
wpIP=${wpIP#*:}
wpIP=${wpIP#*:}
rm createwp.tmp
knife solo prepare ubuntu@$(echo $wpIP)
cp nodes/wp.json nodes/$(echo $wpIP).json
knife solo cook ubuntu@$(echo $wpIP)
echo "WordPress-Server ready and running."
echo "All done. Your WordPress-Instance: $wpIP"
