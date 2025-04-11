# AKS Best Practices 

## Common Sense / Important 

### **RBAC and Authentication**:

- Implement Kubernetes Role-Based Access Control (RBAC) and integrate with Entra ID for secure identity management.
- Limit exposure of the Kubernetes API server by restricting access via firewalls or IP whitelisting.
- Keep Clusters Up-to-Date: Regularly update the AKS cluster version and node OS images to incorporate security patches and performance improvements.

### **Monitoring and Logging**:

- Enable monitoring with Azure Monitor and Container insights.
- Collect logs and metrics for auditing, troubleshooting, and anomaly detection.

### **Network Segmentation and Isolation**:

- Implement network policies to segment and restrict communication between pods and services.
- Consider using private clusters and VNet integration to isolate cluster traffic.

### **Secure Container Images**:

- Ensure container images come from trusted sources and enforce image signing where possible.

> **REMEMBER** to schedule updates hence be prepared for the downtimes 

## Azure Recommended 

### **Entra ID Integration & Managed Identities**:

- Integrate AKS with Entra ID for both cluster and application-level authentication.
- Leverage managed identities for pods to eliminate hard-coded credentials and improve security.

### **Private Endpoints and Network Security**:

- Utilize private endpoints to restrict access to the AKS API and related services.
- Adopt advanced network security measures such as configuring Network Security Groups (NSGs) to control ingress and egress traffic.

### **Pod Security Policies / Admission Controllers**:

- Implement Pod Security Policies (or alternatives like OPA Gatekeeper) to enforce security standards at the pod level (e.g., non-root containers, resource limits).

### **Container Image Scanning and Registry Security**:

- Regularly scan images for vulnerabilities using tools integrated with Azure Container Registry (ACR).
- Enable content trust and vulnerability assessments for images stored in ACR.

### **Automated Backups and Disaster Recovery**:

- Regularly back up cluster configurations and persist critical application data.
- Design clusters for high availability (e.g., using multiple availability zones).

### **Infrastructure as Code (IaC)**:

- Deploy and manage AKS clusters using ARM templates, Bicep, or Terraform for consistent and reproducible environments.

## Not That Important / Can Leave Out 

### **Excessive Node Customization**:

- Unless there are specific performance or workload requirements, avoid over-tuning node configurations—default settings are typically sufficient.

### **Custom CNI Plugins**:

- For most scenarios, the default Azure CNI or Kubenet is adequate; custom CNI plugins may add complexity without significant benefit.

### **Over-Engineering Monitoring Solutions**:

- If Azure Monitor and Container insights meet your needs, complex third-party monitoring integrations might be unnecessary.

### **Rarely Used Advanced Configurations**:

- Certain advanced features (e.g., custom scheduler configurations) can often be left at default unless your environment demands fine-tuning.

## Additional Considerations 

### **Regular Security Audits and Penetration Testing**:

- Periodically review the security posture of your cluster and perform penetration tests to identify potential vulnerabilities.

### **Disaster Recovery and High Availability**:

- Test backup and recovery procedures regularly to ensure minimal downtime in case of failure.
- Utilize cluster auto-scaling and multi-zone deployments to handle varying loads and node failures.

### **Documentation and Team Training**:

- Maintain clear documentation of your AKS environment and best practices.
- Ensure that your team is trained in Kubernetes operations, security practices, and the nuances of managing AKS.