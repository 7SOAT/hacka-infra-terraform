<ol start="1">
  <li>
    <h3>Clonando o repositório</h3>

    git clone https://github.com/7SOAT/hacka-infra-terraform.git
    cd hacka-infra-terraform
  </li>
  <li>
    <h3>Instalar bibliotecas</h3>
    <p>Para instalar as bibliotecas, abra o terminal na raiz do projeto e execute o seguinte comando:</p>

    npm install
  </li>
  <li>
    <h3> Rodar instâncias no Terraform </h3>
    <p>No terminal rode o seguinte código:</p>
    <p> - Para windows:</p>

      cd Terraform && terraform init && terraform apply

   <p> - Para Linux/macOS</p>

     cd Terraform && terraform init && terraform apply

   Se for necessário permissão de administrador (caso veja erros de permissão), use:
   
     sudo terraform apply

</ol>
