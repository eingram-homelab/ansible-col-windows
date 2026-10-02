# Rename physical NICs for consistency
Rename-NetAdapter -Name "Ethernet0" -NewName "MGMT"
Rename-NetAdapter -Name "Ethernet1" -NewName "LM"
Rename-NetAdapter -Name "Ethernet2" -NewName "S2D"
Rename-NetAdapter -Name "Ethernet3" -NewName "VMNetwork"

# Enable jumbo frames
Set-NetAdapterAdvancedProperty -Name S2D -RegistryKeyword "*JumboPacket" -RegistryValue 9014
New-VMSwitch -Name "SW-VM-Network" -NetAdapterName "VMNetwork" -AllowManagementOS $false
# Set network metrics
# Set-NetIPInterface -InterfaceAlias "MGMT" -InterfaceMetric 10
# Set-NetIPInterface -InterfaceAlias "LM" -InterfaceMetric 20
# Set-NetIPInterface -InterfaceAlias "S2D" -InterfaceMetric 30


# Set network weights


# Create the SET switch (switch-independent, no LACP needed)
# New-VMSwitch -Name "ConvergedSwitchLAN" -NetAdapterName "MGMT","LM" -EnableEmbeddedTeaming $true -AllowManagementOS $false

# New-VMSwitch -Name "ConvergedSwitchS2D" -NetAdapterName "S2D" -EnableEmbeddedTeaming $true -AllowManagementOS $false

# # Create host vNICs
# If (!(Get-VMNetworkAdapter -ManagementOS -Name "Management")) {
#   Add-VMNetworkAdapter -ManagementOS -Name "Management" -SwitchName "ConvergedSwitchLAN"
# }
# If (!(Get-VMNetworkAdapter -ManagementOS -Name "SMB_1")) {
#   Add-VMNetworkAdapter -ManagementOS -Name "SMB_1" -SwitchName "ConvergedSwitchS2D"
# }
# If (!(Get-VMNetworkAdapter -ManagementOS -Name "SMB_2")) {
#   Add-VMNetworkAdapter -ManagementOS -Name "SMB_2" -SwitchName "ConvergedSwitchS2D"
# }
# # Tag VLANs
# Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB_1" -Access -VlanId 30
# Set-VMNetworkAdapterVlan -ManagementOS -VMNetworkAdapterName "SMB_2" -Access -VlanId 30

# # Pin storage vNICs to specific physical NICs for concurrent multichannel throughput
# Set-VMNetworkAdapterTeamMapping -ManagementOS -VMNetworkAdapterName "SMB_1" -PhysicalNetAdapterName "S2D"
# Set-VMNetworkAdapterTeamMapping -ManagementOS -VMNetworkAdapterName "SMB_2" -PhysicalNetAdapterName "S2D"

# # Restart the host vNICs so they pick up VLAN/mapping changes
# Restart-NetAdapter -Name "vEthernet (SMB_1)","vEthernet (SMB_2)"