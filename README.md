<h1 align="center"> 🏗️ Hackathon - Infra Terraform </h1>

<p align="left">
  <a href="https://viewer.diagrams.net/index.html?tags=%7B%7D&lightbox=1&highlight=0000ff&layers=1&nav=1&title=hackathon-video-framer.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1iZKwTulRhUoC2yItYfIwjQlRbT8_YyDv%26export%3Ddownload#%7B%22pageId%22%3A%22Kp5rze23rEPJkmFxVfdC%22%7D" 
     style="display: inline-flex; align-items: center; text-decoration: none; margin-bottom: 10px;">
    <img src="https://upload.wikimedia.org/wikipedia/commons/3/3e/Diagrams.net_Logo.svg" width="30" style="vertical-align: middle; margin-right: 10px;">
    <span> Acesse o diagrama no draw.io</span>
  </a> 
  <br>

  <a href="https://www.notion.so/Hackathon-Extra-o-de-Frames-17eebb738629801bb3dcf92ab0b4d4fc" 
     style="display: inline-flex; align-items: center; text-decoration: none;">
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/45/Notion_app_logo.png" width="30" style="vertical-align: middle; margin-right: 10px;">
    <span> Acesse a documentação no Notion</span>
  </a>
</p>

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
