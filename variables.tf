variable "project-name"{

description=""

}

variable "region"{

description=""
default="us-east-1a"

}

variable "Environment"{
    description = "specify-env-name"
}

variable "cidr_block"{
    description = "specify-cidr_range"
}

variable "terraform"{
    type=bool
    default="true"
}

variable "public-subnets"{

    default={
        public_subnet_A={
            Name=""
            cidr_block=""
            azone=""
        }
        public_subnet_B={
            Name=""
            cidr_block=""
            azone=""
        }
    }

}

variable "private-subnets"{

    default={

        private_subnet_A={
            Name=""
            cidr_block=""
            azone=""
        }
        private_subnet_B={
            Name=""
            cidr_block=""
            azone=""
        }
    }
}

variable "public-route-tbl"{
    type=list 
    default=["A","B","C"]
}

