# This is copied directly from the spire/support/k8s/k8s-workload-registrar tree.
# These roles are needed for the k8s registrar to work properly in reconciling mode.
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: spire-k8s-registrar-cluster-role
rules:
  - apiGroups: [""]
    resources: ["pods", "nodes", "endpoints"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: spire-k8s-registrar-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spire-k8s-registrar-cluster-role
subjects:
  - kind: ServiceAccount
    name: spire-k8s-registrar
    namespace: spire
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: spire-k8s-registrar-role
  namespace: spire
rules:
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["create"]
  - apiGroups: [""]
    resources: ["configmaps"]
    resourceNames: ["controller-leader-election-helper"]
    verbs: ["update", "get"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: spire-k8s-registrar-role-binding
  namespace: spire
subjects:
  - kind: ServiceAccount
    name: spire-k8s-registrar
    namespace: spire
roleRef:
  kind: Role
  name: spire-k8s-registrar-role
  apiGroup: rbac.authorization.k8s.io
