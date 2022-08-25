# Also add --save_main_session ?
# https://stackoverflow.com/questions/69315695/modulenotfounderror-while-running-apache-beam-job-in-dataflow-using-setup-py
#   --save_main_session \
#
GCP_BUCKET_NAME=your_gcp_bucket_name
GCP_PROJECT=your_gcp_project
GCP_REGION=us-east1
GCP_SUBNETWORK_NAME=your_gcp_subnetwork_name
GCP_SUBNETWORK=https://www.googleapis.com/compute/v1/projects/$GCP_PROJECT/regions/$GCP_REGION/subnetworks/$GCP_SUBNETWORK_NAME

dt=`date +%Y%m%d-%H%M%S`
echo "dt is $dt"
python juliaset_main.py \
  --job_name juliaset-$USER-$dt \
  --project $GCP_PROJECT \
  --region $GCP_REGION \
  --runner DataflowRunner \
  --save_main_session \
  --setup_file ./setup.py \
  --staging_location gs://$GCP_BUCKET_NAME/juliaset/staging \
  --subnetwork "$GCP_SUBNETWORK" \
  --temp_location gs://$GCP_BUCKET_NAME/juliaset/temp \
  --coordinate_output gs://$GCP_BUCKET_NAME/juliaset/out \
  --grid_size 20
