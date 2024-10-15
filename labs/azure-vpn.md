# Azure VPN Gateway

October 15, 2024. I needed to create a VPN Gateway in an Azure Resource Group. I had some issues so I thought I'd write down a few of the steps, to make future me happy.

1. Here's a great site from Microsoft about the [differnet VPN Gateway Topologies and designs](https://learn.microsoft.com/en-us/azure/vpn-gateway/design#s2smulti).
2. Here's the tutorial to configuring a [S2S VPN connection](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal) between Azure and Ubiquiti (UBQ not included).
3. The tutorial worked great, but it was my end device that I needed to configure. Here's the steps on the ubiquiti side:
   1. From the Ubiquiti console > Settings > VPN > Site-to-Site VPN.
   2. Give it a name (site-to-site).
   3. Enter in the pre-shared key. Exact same one defined when deploying the VPN Gateway in Azure.
   4. Local IP. Do not change. This is your public ISP IP address.
   5. Remote IP is the public IP assigned to the Azure VPN Gateway.
   6. VPN Type: Route Based
   7. Remote Networks: (What Azure remote networks). I have 10.0.0.0/8 to cover everything, if that's what you've configured in your Azure VPC.
   8. Advanced > Manual.
      1. Key Exchange Version: IKEv2
      2. IKE Encryption: AES-256
      3. Hash: SHA1
      4. DH Group: 2
      5. Lifetime: 28800
      6. Perfect Forward Secrecy (PFS): Checked
      7. Local Authencation: Checked Auto
      8. Remote Authentication ID: Auto checked
      9. Max Transmission Unit: Auto Checked
      10. Route Distance: 30
