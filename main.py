import boto3

# ---------SETTINGS----------------
image_id = 'ami-0574da719dca65348'  # ubuntu 22.04
key_name = 'vockey'
standalone_instance_type = 't2.micro'
cluster_instance_type = 't2.micro'
cluster_instance_count = 4

# ----------SCRIPT-----------------
ec2_client = boto3.client("ec2")
ec2_resource = boto3.resource("ec2")
elbv2_client = boto3.client('elbv2')

with open('initStandalone.sh', 'r') as file:
    standalone_init_script = file.read()

with open('initCluster.sh', 'r') as file:
    cluster_init_script = file.read()

standalone_instance = ec2_client.run_instances(
    ImageId=image_id,
    MinCount=1,
    MaxCount=1,
    InstanceType=standalone_instance_type,
    KeyName=key_name,
    UserData=standalone_init_script
)

##cluster_instances = ec2_client.run_instances(
#    ImageId=image_id,
#    MinCount=cluster_instance_count,
#    MaxCount=cluster_instance_count,
#    InstanceType=cluster_instance_type,
#    KeyName=key_name,
#    UserData=cluster_init_script
#)