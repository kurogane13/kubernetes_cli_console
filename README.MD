# Kubernetes CLI Helper

## AUTHOR: GUSTAVO WYDLER AZUAGA
## VERSION: 1
## RELEASE DATE: 10-18-2024

A simple, user-friendly bash script for managing Kubernetes clusters efficiently. This tool provides an interactive menu-based interface to perform common Kubernetes operations, reducing the need for manual command typing and enhancing productivity.

---

## 📜 Features

- **Node Management**
  - Retrieve nodes (`get nodes`) and wide node views.
  - Describe specific nodes for detailed information.

- **Pod Management**
  - List pods with namespace filtering.
  - Describe, start, stop, restart, and delete pods.
  - Create pods from images or configuration files.
  - Change pod images with an interactive editor.

- **Deployment Management**
  - List and scale deployments.
  - Change deployment images and apply configurations.

- **Namespace Management**
  - View all namespaces and set a specific namespace as the default.

- **Service Management**
  - View Kubernetes services by namespace.

- **Advanced Operations**
  - Execute commands in running pods.
  - Retrieve logs from specific pods.
  - Apply configuration files to update resources.
  - Delete any resource (pods, services, deployments, etc.) with ease.

---

## 🎯 Scope

The **Kubernetes CLI Helper** is designed for system administrators and developers working in Kubernetes environments. It simplifies cluster management by providing quick access to common commands via an interactive menu system.

---

## 💻 How to Use

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/kubernetes-cli-helper.git
   cd kubernetes-cli-helper
   bash kubernets_cli.sh
   ```
