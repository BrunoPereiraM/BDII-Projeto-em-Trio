select 
		iddespesa as "Identificação da Despesa", 
		colaborador_cpf as "CPF do Colaborador"
from 
	despesa
order by 
		iddespesa;

select 
idcompra as "Identificação da compra",
date_format(data, "%d/%m/%Y") as "Data",
concat('R$ ', format(valor, 2, 'de_DE')) as "Preço", 
descricao as "Descrição" 
from 
compra;

select * from endereco_cliente;

select * from colaborador where cpf in ('123.456.789-00', '987.654.321-00');
select * from cliente;

select 
		c.cpf as "CPF do Cliente",
        c.nome as "Nome do Cliente", 
        date_format(c.dataNasc, "%d/%m/%Y") as "Data de Nascimento", 
        e.rua as "Rua", 
        e.numero as "Nº", 
        e.bairro as "Bairro", 
        e.cidade as "Cidade", 
        e.estado as "Estado", 
        e.cep as "CEP"
from cliente c
join endereco_cliente e on c.cpf = e.cpf
where e.cidade = 'São Paulo';

select * from endereco_colaborador;

select 
		cpf as "CPF do Cliente",
        nome as "Nome do Cliente", 
        date_format(dataNasc, "%d/%m/%Y") as "Data de Nascimento"
from 
	cliente;

select 	cliente_cpf as "CPF do Cliente", 
		coalesce(tel1, "Não informado") as "Telefone 1º", 
        coalesce(tel2, "Não informado") as "Telefone 2º" 
        
from 
telefone_cli;

select 
		col.nome as "Nome do Colaorador", 
        col.cpf "CPF do Colaborador", 
        end.rua as "Rua", 
        end.numero "Nº", 
        end.bairro "Bairro", 
        end.cidade as "Cidade", 
        end.estado as "Estado", 
        end.cep as "CEP"
from colaborador col
inner join endereco_colaborador end on col.cpf = end.cpf;


select 
		idregistro as "ID do Registro",
        recomendacao as "Recomendação", 
        detalhe as "Detalhe", 
        prescricao as "Precrição", 
        cliente_cpf as "CPF do Cliente", 
		colaborador_cpf as "CPF do Colaborador"
from registro;

select
		colaborador_cpf as "CPF do Colaborador", 
		coalesce(tel1, "Não informado") as "Telefone 1º", 
        coalesce(tel2, "Não informado") as "Telefone 2º" 
from tel_colab;

select 
		agendamento_idagendamento as "Nº de Agendamento", 
        colaborador_cpf as "CPF do Colaborador"
from 
	consulta;

select 
		idfolha_pag as "Folha de Pagamento",
        date_format(data, "%d/%m/%Y") as "Data",
        concat('R$ ', format(valor, 2, 'de_DE')) as "Preço", 
        despesa_iddespesa as "Identificação da Despesa"
from folha_pag;

select 	
		idcustos as "Identificação de Cuusto",
        date_format(data, "%d/%m/%Y") as "Data",
        descricao as "Descrição",
        concat('R$ ', format(valor, 2, 'de_DE')) as "Preço", 
        despesa_iddespesa as "Identificação da Despesa"
from 
custos
order by
idcustos;

select 
		idlaboratorio as "Idetificação do Laboratório", 
		nome as "Nome", 
		despesa_iddespesa as "Identificação da Despesa"
from laboratorio;


select 
		c.cpf as "CPF do Cliente",
        c.nome as "Nome do Cliente",
        coalesce(t.tel1, "Não informado") as "Telefone 1º", 
        coalesce(t.tel2, "Não informado") as "Telefone 2º"
from cliente c
left join telefone_cli t ON c.cpf = t.cliente_cpf;


select
		idservico as "Identifficação do Serviço",
        date_format(data, "%d/%m/%Y") as "Data",
        descricao as "Descrição",
        concat('R$ ', format(valor, 2, 'de_DE')) as "Preço",
        laboratorio_idlaboratorio as "Identificação do Laboratório"
from 
	servico;


select 
		f.procedimento "Procedimento",
		date_format(f.data, "%d/%m/%Y") as "Data",
		concat('R$ ', format(f.valor_recebido, 2, 'de_DE')) as "Valor Recebido",
        fp.tipo as "Tipo de Pagamento"
from faturamento f
inner join lucro l on f.idfaturamento = l.faturamento_idfaturamento
inner join forma_pagamento fp on l.forma_pagamento_idforma_pagamento = fp.idforma_pagamento;

select 
		a.idagendamento as "Idetificação do Agendamento", 
        a.status as "Status", 
        p.descricao as "Descrição", 
        concat('R$ ', format(p.custo, 2, 'de_DE')) as "Preço"
from agendamento a
left join procedimento p ON a.idagendamento = p.agendamento_idagendamento;


