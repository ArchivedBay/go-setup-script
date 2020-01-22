tools_loc="/tools"
go_ver="1.13.6"

# create required dirs
echo 'making tools directory and required go subdirs if needed...'
mkdir -p $tools_loc $HOME/go/{bin,pkg,src}

# get the go binary
echo 'downloading Go binary and creating symlink...'
curl -sL "https://dl.google.com/go/go$go_ver.linux-amd64.tar.gz" -o $tools_loc/go-$go_ver.tar.gz
tar -xzf $tools_loc/go-$go_ver.tar.gz -C $tools_loc && mv $tools_loc/go $tools_loc/go-$go_ver
ln -s $tools_loc/go-$go_ver $tools_loc/go

# update PATH with required go vars
echo 'setting up PATH for go...'
echo '# for go'                              >> ~/.bashrc
echo 'export PATH="$tools_loc/bin/go:$PATH"' >> ~/.bashrc
echo 'export GOPATH="$HOME/go"'              >> ~/.bashrc
echo 'export PATH="$GOPATH/bin:$PATH"'       >> ~/.bashrc

# reload the shell to take effect
echo 'reloading shell...'
. ~/.bashrc

# creating a dummy project to verify go installation
cd $GOPATH/src
mkdir say && cd say && cat << EOT >>main.go
  package main

  import "fmt"

  func main() {
	fmt.Println("Go installed successfully!")
  }
EOT
go install
say
