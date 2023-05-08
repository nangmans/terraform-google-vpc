# terraform-google-vpc

이 모듈은 [terraform-google-module-template](https://stash.wemakeprice.com/users/lswoo/repos/terraoform-google-module-template/browse)에 의해서 생성되었습니다. 

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided namemark

## Usage

모듈의 기본적인 사용법은 다음과 같습니다:

```hcl
module "vpc" {
  source  = "git::https://stash.wemakeprice.com/scm/tgm/terraform-google-vpc.git"

  project_id  = "my-prod-project"
  network_name = "vpc-network-1"
}
```

모듈 사용의 예시는 [examples](./examples/) 디렉토리에 있습니다.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_create\_subnetworks | true로 설정시, Network는 "auto subnet mode"로 생성되어 10.128.0.0/9 범위에 걸쳐 각 리전에 자동으로 서브넷을 생성합니다. false로 설정시, Network는 "custom subent mode"로 생성되어 사용자가 명시적으로 Subnet을 생성해야 합니다. | `bool` | `false` | no |
| delete\_default\_internet\_gateway\_routes | 설정시, 이름이 'default-route'로 시작하고 next hop이 'default-internet-gateway'인 모든 Route들을 삭제합니다. | `bool` | `false` | no |
| description | 리소스에 대한 설명입니다. 이 필드를 수정 시 리소스는 재생성됩니다. | `string` | `""` | no |
| enable\_ula\_internal\_ipv6 | 네트워크에 ULA internal ipv6 를 활성화합니다. 이 기능을 활성화하면 google defined ULA prefix fd20::/20에서 /48 범위를 할당합니다. | `bool` | `false` | no |
| internal\_ipv6\_range | ula internal ipv6 를 활성화했을시, 이 기능을 통해 google defined ULA prefix fd20::/20에서 원하는 /48 범위를 지정할 수 있습니다. | `string` | `""` | no |
| mtu | 네트워크 MTU (0로 설정시, 즉 미설정시, 기본값 1460으로 설정됨)추천값 : 1460 (default) , 1500 (Internet default) , 8896 (Jumbo packet). 1300에서 8896 사이의 값이 허용됩니다. | `number` | `0` | no |
| network\_name | 생성될 네트워크의 이름 | `any` | n/a | yes |
| peering\_config | VPC 피어링 설정. <br /> peer_vpc_self_link : Peering을 맺을 peer VPC의 self link.<br />create_remote_peer : VPC Peering Peer 리소스 생성 여부.<br /> export_routes : routes export 여부.<br /> import_routes : routes import 여부.| <pre>object({<br>    peer_vpc_self_link = string<br>    create_remote_peer = optional(bool, true)<br>    export_routes = optional(bool)<br>    import_routes = optional(bool) })</pre> | `null` | no |
| project\_id | VPC가 생성될 Project의 ID | `any` | n/a | yes |
| routing\_mode | Network의 라우팅 모드 (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| shared\_vpc\_host | true로 설정시, 해당 프로젝트는 Shared VPC의 Host project로 설정됩니다. (default 'false') | `bool` | `false` | no |
| shared\_vpc\_service\_projects | shared_vpc_host가 true일시, Shared vpc의 Host project에 attach할 service project의 리스트 | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| network | 생성됨 VPC 리소스 |
| network\_id | 생성됨 VPC의 ID |
| network\_name | 생성된 VPC의 이름 |
| network\_self\_link | 생성된 VPC의 URI |
| project\_id | VPC의 Project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

이 모듈을 사용하기 위해 필요한 사항을 표기합니다.

### Software

아래 dependencies들이 필요합니다:

- [Terraform][terraform] v1.3
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v4.40.0

### Service Account

이 모듈의 리소스를 배포하기 위해서는 아래 역할이 필요합니다:

- Compute Network Admin: `roles/compute.networkAdmin`
- Compute Shared XPN Admin: `roles/compute.xpnAdmin`

[Project Factory module][project-factory-module] 과
[IAM module][iam-module]로 필요한 역할이 부여된 서비스 어카운트를 배포할 수 있습니다.

### APIs

이 모듈의 리소스가 배포되는 프로젝트는 아래 API가 활성화되어야 합니다:

- Compute Engine API

[Project Factory module][project-factory-module]을 이용해 필요한 API를 활성화할 수 있습니다..

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).

## TO DO

- [ ] Example README 번역
