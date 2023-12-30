resource "aws_vpc" "vpc_A"{
    cidr_block = var.cidr_block
    tags = {
      Name= var.project-name
      executebyterraform=var.terraform
      env= var.Environment

    }
}

resource "aws_subnet" "public-subnets"{
   for_each = var.public-subnets
   vpc_id = aws_vpc.vpc_A.id 
   cidr_block = each.value.cidr_block
   availability_zone = each.azone

   tags={
      
      Name=each.name
      executebyterraform=var.terraform
      env= var.Environment
   }
}

resource "aws_subnet" "private-subnets"{
    for_each = var.private-subnets
    vpc_id = aws_vpc.vpc_A.id 
    cidr_block = each.value.cidr_block
    availability_zone=each.value.azone

    tags={
        Name=each.name
        executebyterraform=var.terraform
        env= var.Environment
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id=aws_vpc.vpc_A.id
    
     tags={
        Name="igw-${var.project-name}"
        env=var.Environment
        executebyterraform=var.terraform
    }
}
resource "aws_route_table" "route-table"{
    
    for_each= var.public-subnets
    vpc_id = aws_vpc.vpc_A.id
    //for_each=var.public_subnets
    route {
        cidr_block=each.value.cidr_block
        gateway_id = aws_internet_gateway.igw.id
    }
    tags={
        Name="public-route-${var.public-route-tbl[count.index]}"
        env=var.Environment
        executebyterraform=var.terraform
    }
}

resource "aws_route_table_association" "subent-associations"{
   for_each=var.public-subnets
   route_table_id=aws_route_table.route-table[each.key].id
   subnet_id= aws_subnet.public-subnets[each.key].id
}

resource "aws_route_table" "prvt-route-table"{
    
    for_each= var.private-subnets
    vpc_id = aws_vpc.vpc_A.id
    //for_each=var.public_subnets
    route {
        cidr_block=each.value.cidr_block
        
   }
    tags={
        Name="private-route-${var.public-route-tbl[count.index]}"
        env=var.Environment
        executebyterraform=var.terraform
    }
}

resource "aws_route_table_association" "prvt-subent-associations"{
   for_each=var.private-subnets
   route_table_id=aws_route_table.prvt-route-table[each.key].id
   subnet_id= aws_subnet.private-subnets[each.key].id
}

