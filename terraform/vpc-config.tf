provider "aws" {
region     = "us-east-1"
}


# ---  Creating a VPC ------


resource "aws_vpc" "abhi134" {
  cidr_block       = "10.10.0.0/16"
  tags = {
    Name = "abhi134"
  }
}



#--- Creating Internet Gateway


resource "aws_internet_gateway" "abhi134_igw" {
 vpc_id = "${aws_vpc.abhi134.id}"
 tags = {
    Name = "abhi134-igw"
 }
}


# - Creating Elastic IP


resource "aws_eip" "abhi134-eip" {
  vpc=true
}

# -- Creating Subnet


data "aws_availability_zones" "abhi134-azs" {
  state = "available"
}



        #  creating public subnet


resource "aws_subnet" "abhi134-public-subnet-1a" {
  availability_zone = "${data.aws_availability_zones.abhi134-azs.names[0]}"
  cidr_block        = "10.10.20.0/24"
  vpc_id            = "${aws_vpc.abhi134.id}"
  map_public_ip_on_launch = "true"
  tags = {
   Name = "abhi134-public-subnet-1a"
   }
}

resource "aws_subnet" "abhi134-public-subnet-1b" {
  availability_zone = "${data.aws_availability_zones.abhi134-azs.names[1]}"
  cidr_block        = "10.10.21.0/24"
  vpc_id            = "${aws_vpc.abhi134.id}"
  map_public_ip_on_launch = "true"
  tags = {
   Name = "abhi134-public-subnet-1b"
   }
}


        #  Creating  private subnet


resource "aws_subnet" "abhi134-private-subnet-1a" {
  availability_zone = "${data.aws_availability_zones.abhi134-azs.names[0]}"
  cidr_block        = "10.10.30.0/24"
  vpc_id            = "${aws_vpc.abhi134.id}"
  tags = {
   Name = "abhi134-private-subnet-1a"
   }
}


resource "aws_subnet" "abhi134-private-subnet-1b" {
  availability_zone = "${data.aws_availability_zones.abhi134-azs.names[1]}"
  cidr_block        = "10.10.31.0/24"
  vpc_id            = "${aws_vpc.abhi134.id}"
  tags = {
   Name = "abhi134-private-subnet-1b"
   }
}





# --------------  NAT Gateway

resource "aws_nat_gateway" "abhi134-ngw" {
  allocation_id = "${aws_eip.abhi134-eip.id}"
  subnet_id = "${aws_subnet.abhi134-public-subnet-1b.id}"
  tags = {
      Name = "abhi134-Nat Gateway"
  }
}




# ------------------- Routing ----------


resource "aws_route_table" "abhi134-public-route" {
  vpc_id =  "${aws_vpc.abhi134.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.abhi134_igw.id}"
  }

   tags = {
       Name = "abhi134-public-route"
   }
}


resource "aws_default_route_table" "abhi134-default-route" {
  default_route_table_id = "${aws_vpc.abhi134.default_route_table_id}"
  tags = {
      Name = "abhi134-default-route"
  }
}



#--- Subnet Association -----

resource "aws_route_table_association" "abhi134-1a" {
  subnet_id = "${aws_subnet.abhi134-public-subnet-1a.id}"
  route_table_id = "${aws_route_table.abhi134-public-route.id}"
}


resource "aws_route_table_association" "abhi134-1b" {
  subnet_id = "${aws_subnet.abhi134-public-subnet-1b.id}"
  route_table_id = "${aws_route_table.abhi134-public-route.id}"
}


resource "aws_route_table_association" "abhi134-p-1a" {
  subnet_id = "${aws_subnet.abhi134-private-subnet-1a.id}"
  route_table_id = "${aws_vpc.abhi134.default_route_table_id}"
}

resource "aws_route_table_association" "abhi134-p-1b" {
  subnet_id = "${aws_subnet.abhi134-private-subnet-1b.id}"
  route_table_id = "${aws_vpc.abhi134.default_route_table_id}"
}
