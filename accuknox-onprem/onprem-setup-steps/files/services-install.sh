#!/bin/bash
echo "creating all required namespaces"
pwd
kubectl create ns accuknox-user-mgmt
kubectl create ns accuknox-agents-auth-service
kubectl create ns accuknox-ad-core
kubectl create ns accuknox-cluster-mgmt
kubectl create ns accuknox-ad-mgmt
kubectl create ns accuknox-dp-mgmt
kubectl create ns accuknox-dp-core
kubectl create ns accuknox-s3-audit-reporter-consumer
kubectl create ns accuknox-data-classification-pipeline-consumer
kubectl create ns accuknox-adc
kubectl create ns accuknox-cluster-onboard
kubectl create ns accuknox-cluster-entity-daemon
kubectl create ns accuknox-shared-informer-service
kubectl create ns accuknox-datapipeline-api
kubectl create ns accuknox-temporal
kubectl create ns accuknox-samzajobs
kubectl create ns accuknox-feeder-grpc-server
kubectl create ns accuknox-policy-service
kubectl create ns accuknox-policy-daemon
kubectl create ns accuknox-policy-provider-service
kubectl create ns accuknox-workload-identity-daemon
kubectl create ns accuknox-recommended-policy-daemon
kubectl create ns accuknox-discovered-policy-daemon
kubectl create ns accuknox-label-service
kubectl create ns accuknox-knoxautopolicy

echo "keycloak Installing"
helm upgrade --install accuknox-keycloak accuknox-onprem-services/keycloak-chart -n accuknox-user-mgmt
sleep 1m

echo "User management Installing"
echo "istio auto injecting sidecar is enabling on namespace level"
kubectl label namespace accuknox-user-mgmt istio-injection=enabled
#helm upgrade --install accuknox-user-mgmt-service accuknox-onprem-services/user-management-service-chart -n accuknox-user-mgmt

echo "agents-auth-service Installing"
echo "istio auto injecting sidecar is enabling on namespace level"
kubectl label namespace accuknox-agents-auth-service istio-injection=enabled
helm upgrade --install accuknox-agents-auth-service  accuknox-onprem-services/agents-auth-service-charts -n accuknox-agents-auth-service

echo "cluster-mgmt Installing"
kubectl label namespace accuknox-cluster-mgmt istio-injection=enabled
helm upgrade --install accuknox-cluster-mgmt accuknox-onprem-services/cluster-management-service-chart -n accuknox-cluster-mgmt

echo "anomaly-detection-mgmt Installing"
kubectl label namespace accuknox-ad-mgmt istio-injection=enabled
helm upgrade --install accuknox-ad-mgmt accuknox-onprem-services/anomaly-detection-mgmt-chart -n accuknox-ad-mgmt

echo "data-protection-mgmt Installing"
kubectl label namespace accuknox-dp-mgmt istio-injection=enabled
helm upgrade --install accuknox-dp-mgmt accuknox-onprem-services/data-protection-mgmt-chart -n accuknox-dp-mgmt

echo "anomaly-detection-mgmt Installing"
helm upgrade --install accuknox-ad-core accuknox-onprem-services/anomaly-detection-publisher-core-chart -n accuknox-ad-core

echo "anomaly-detection-publisher-core Installing"
helm upgrade --install accuknox-dp-core accuknox-onprem-services/data-protection-core -n accuknox-dp-core

echo "data-protection-consumer Installing"
helm upgrade --install accuknox-data-protection-consumer accuknox-onprem-services/data-protection-consumer -n accuknox-dp-core

echo "s3-audit-reporter-consumer Installing"
helm upgrade --install accuknox-s3-audit-reporter-consumer accuknox-onprem-services/s3-audit-reporter-consumer-charts -n accuknox-s3-audit-reporter-consumer

echo "dp-db-audit-log-processor Installing"
helm upgrade --install accuknox-dp-db-audit-log-processor accuknox-onprem-services/dp-db-audit-log-processor-chart -n accuknox-dp-core

echo "data-classification-pipeline-consumer"
helm upgrade --install accuknox-data-classification-pipeline-consumer accuknox-onprem-services/data-classification-pipeline-consumer-chart -n accuknox-data-classification-pipeline-consumer

echo "agent-data-collector Installing"
kubectl label namespace accuknox-adc istio-injection=enabled
helm upgrade --install accuknox-adc accuknox-onprem-services/agent-data-collector-charts -n accuknox-adc

echo "cluster-onboarding-service Installing"
kubectl label namespace accuknox-cluster-onboard istio-injection=enabled
helm upgrade --install accuknox-cluster-onboard accuknox-onprem-services/cluster-onboarding-service -n accuknox-cluster-onboard

echo "cluster-entity-daemon Installing"
helm upgrade --install accuknox-cluster-entity-daemon accuknox-onprem-services/cluster-entity-daemon-chart -n accuknox-cluster-entity-daemon

echo "shared-informer-service Installing"
# helm upgrade --install accuknox-shared-informer-service accuknox-onprem-services/shared-informer-service-chart -n accuknox-shared-informer-service

echo "datapipeline-api Installing"
kubectl label namespace accuknox-datapipeline-api istio-injection=enabled
# helm upgrade --install accuknox-datapipeline-api accuknox-onprem-services/data-pipeline-api-charts -n accuknox-datapipeline-api

echo "datapipeline-temporal Installing"
kubectl label namespace accuknox-temporal istio-injection=enabled
helm upgrade --install accuknox-temporal accuknox-onprem-services/datapipeline-temporal-charts -n accuknox-temporal

echo "zookeeper Installing"
helm upgrade --install accuknox-zookeeper accuknox-onprem-services/zookeeper -n accuknox-samzajobs

echo "datapipeline-samza Installing"
helm upgrade --install accuknox-samzajobs accuknox-onprem-services/datapipeline-samza -n accuknox-samzajobs

echo "feeder-grpc-server  Installing"
helm upgrade --install accuknox-feeder-grpc-server accuknox-onprem-services/feeder-grpc-server-chart -n accuknox-feeder-grpc-server

echo "policy-service Installing"
kubectl label namespace accuknox-policy-service istio-injection=enabled
helm upgrade --install accuknox-policy-service accuknox-onprem-services/policy-service-charts -n accuknox-policy-service

echo "policy-daemon Installing"
helm upgrade --install accuknox-policy-daemon accuknox-onprem-services/policy-daemon-charts -n accuknox-policy-daemon

echo "policy-provider-service Installing"
kubectl label namespace accuknox-policy-provider-service istio-injection=enabled
helm upgrade --install accuknox-policy-provider-service accuknox-onprem-services/policy-provider-service -n accuknox-policy-provider-service

echo "label-service Installing"
kubectl label namespace accuknox-label-service istio-injection=enabled
helm upgrade --install accuknox-label-service accuknox-onprem-services/label-service-chart -n accuknox-label-service

echo "workload-identity-daemon Installing"
helm upgrade --install accuknox-workload-identity-daemon accuknox-onprem-services/workload-identity-daemon-chart -n accuknox-workload-identity-daemon

echo "recommended-policy-daemon Installing"
helm upgrade --install accuknox-recommended-policy-daemon accuknox-onprem-services/recommended-policy-daemon -n accuknox-recommended-policy-daemon

echo "discovered-policy-daemon Installing"
helm upgrade --install accuknox-discovered-policy-daemon accuknox-onprem-services/discoveredpolicy-daemon-charts -n accuknox-discovered-policy-daemon

echo "knoxautopolicy Installing"
# helm upgrade --install accuknox-knoxautopolicy accuknox-onprem-services/knox-auto-policy-chart -n accuknox-knoxautopolicy

echo "Successfully installed"


