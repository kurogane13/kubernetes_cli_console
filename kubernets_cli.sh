#!/bin/bash

# Title
echo "=============================="
echo "     Kubernetes CLI Helper    "
echo "=============================="

# Main menu
while true; do
    echo ""
    echo "Select an operation:"
    echo
    echo "1. Get Nodes"
    echo "2. Get Nodes (Wide)"
    echo "3. Get Pods"
    echo "4. Get Pods (Wide)"
    echo "5. Get Services"
    echo "6. Get Deployments"
    echo "7. Get Namespaces"
    echo "8. Describe Pod"
    echo "9. Describe Node"
    echo "10. Create Pod with Configuration File"
    echo "11. Create Pod with Image"
    echo "12. Delete Pod"
    echo "13. Start Pod"
    echo "14. Stop Pod"
    echo "15. Restart Pod"
    echo "16. Get Pod IDs"
    echo "17. Get Node IDs"
    echo "18. Change Pod Image"
    echo "19. Change Deployment Image"
    echo "20. Apply Configuration"
    echo "21. Delete Resource"
    echo "22. Execute Command in Pod"
    echo "23. View Pod Logs"
    echo "24. Scale Deployment"
    echo "25. Set Namespace"
    echo "26. Exit"
    echo ""

    # Read user input
    read -p "Enter your choice (1-26): " choice
    echo
    case $choice in
        1)
            echo "Getting nodes..."
            kubectl get nodes
            ;;
        2)
            echo "Getting nodes (wide output)..."
            kubectl get nodes -o wide
            ;;
        3)
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Getting pods..."
            kubectl get pods ${namespace:+-n $namespace}
            ;;
        4)
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Getting pods (wide output)..."
            kubectl get pods ${namespace:+-n $namespace} -o wide
            ;;
        5)
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Getting services..."
            kubectl get svc ${namespace:+-n $namespace}
            ;;
        6)
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Getting deployments..."
            kubectl get deployments ${namespace:+-n $namespace}
            ;;
        7)
            echo "Getting namespaces..."
            kubectl get namespaces
            ;;
        8)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Describing pod..."
            kubectl describe pod $pod_name ${namespace:+-n $namespace}
            ;;
        9)
            read -p "Enter node name: " node_name
            echo "Describing node..."
            kubectl describe node $node_name
            ;;
        10)
            read -p "Enter the path to the pod configuration file: " config_file
            echo "Creating pod from configuration file..."
            kubectl apply -f $config_file
            ;;
        11)
            read -p "Enter pod name: " pod_name
            read -p "Enter container image (e.g., nginx, busybox:1.35): " image
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Creating pod with image..."
            kubectl run $pod_name --image=$image ${namespace:+-n $namespace}
            ;;
        12)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Deleting pod..."
            kubectl delete pod $pod_name ${namespace:+-n $namespace}
            ;;
        13)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Starting pod (reapplying configuration)..."
            kubectl rollout restart pod $pod_name ${namespace:+-n $namespace}
            ;;
        14)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Stopping pod..."
            kubectl delete pod $pod_name --grace-period=0 --force ${namespace:+-n $namespace}
            ;;
        15)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Restarting pod..."
            kubectl delete pod $pod_name ${namespace:+-n $namespace}
            kubectl apply -f $pod_name-config.yaml # Replace with actual configuration path if available
            ;;
        16)
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Getting pod IDs..."
            kubectl get pods ${namespace:+-n $namespace} -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'
            ;;
        17)
            echo "Getting node IDs..."
            kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'
            ;;
        18)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Opening editor to change pod image..."
            kubectl edit pod $pod_name ${namespace:+-n $namespace}
            ;;
        19)
            read -p "Enter deployment name: " deployment_name
            read -p "Enter namespace (leave blank for default): " namespace
            read -p "Enter the path to the deployment definition file (YAML): " definition_file
            echo "Editing deployment definition file..."
            vi $definition_file
            echo "Applying updated deployment..."
            kubectl apply -f $definition_file
            ;;
        20)
            read -p "Enter the path to the configuration file: " config_file
            echo "Applying configuration..."
            kubectl apply -f $config_file
            ;;
        21)
            read -p "Enter the resource type (e.g., pod, svc, deployment): " resource_type
            read -p "Enter the resource name: " resource_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Deleting resource..."
            kubectl delete $resource_type $resource_name ${namespace:+-n $namespace}
            ;;
        22)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            read -p "Enter the command to execute: " command
            echo "Executing command in pod..."
            kubectl exec -it $pod_name ${namespace:+-n $namespace} -- $command
            ;;
        23)
            read -p "Enter pod name: " pod_name
            read -p "Enter namespace (leave blank for default): " namespace
            echo "Viewing logs..."
            kubectl logs $pod_name ${namespace:+-n $namespace}
            ;;
        24)
            read -p "Enter deployment name: " deployment_name
            read -p "Enter namespace (leave blank for default): " namespace
            read -p "Enter the desired replica count: " replicas
            echo "Scaling deployment..."
            kubectl scale deployment $deployment_name --replicas=$replicas ${namespace:+-n $namespace}
            ;;
        25)
            read -p "Enter namespace to set: " namespace
            echo "Setting namespace..."
            kubectl config set-context --current --namespace=$namespace
            ;;
        26)
            echo "Exiting Kubernetes CLI Helper. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
    echo
    # Wait for user to press Enter before showing the main menu again
    read -p "Press Enter to return to the main menu..."
done
