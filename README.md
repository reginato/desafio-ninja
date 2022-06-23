Descrição do Problema
Temos um problema grande com reuniões, elas são muitas e temos poucas salas disponíveis. Precisamos de uma agenda para nos mantermos sincronizados e esse será seu desafio! 
- Temos 4 salas e podemos usá-las somente em horário comercial, 
- Segunda a sexta das 09:00 até as 18:00. 
- Sua tarefa será de criar uma API REST que crie, edite, mostre e delete o agendamento dos horários para que os usuários não se percam ao agendar as salas.

Notas
[x] O teste deve ser escrito utilizando Ruby e Ruby on Rails
[x] Utilize as gems que achar necessário
[x] Não faça squash dos seus commits, gostamos de acompanhar a evolução gradual da aplicação via commits.
[x] Estamos avaliando coisas como design, higiene do código, confiabilidade e boas práticas
[x] Esperamos testes automatizados.
[x] A aplicação deverá subir com docker-compose
[x] Crie um README.md descrevendo a sua solução e as issues caso houver
[x] O desafio pode ser entregue abrindo um pull request ou fazendo um fork do repositório


##DESCRIÇÃO DO DESAFIO

Para criação das salas e o dos usuários basta rodar um seeds, criei apenas o básico para focar no principal 
problema que é a questão dos agendamentos.
Pra isso usei a gem https://github.com/bokmann/business_time
Com ela eu consigo configurar os horários, dias e até feriados fazendo assim que com apenas 1 método
eu consiga validar se a data está dentro do range que precisamos, dentro do horário comercial e de segunda sexta
como mostra o arquivo schedule-room/config/initializers/business_time.rb
São basicamente 3 tabelas:
- Room que guarda as salas.
- User com os usuários.
- Schedule que guarda os agendamentos.

##SUBINDO O PROJETO


```
   docker-compose up
   docker-compose exec web bundle exec rails db:create 
   docker-compose exec web bundle exec rails db:migrate
   docker-compose exec web bundle exec rails db:seed
   docker-compose exec web bundle exec rake spec
```


##EXEMPLOS DE REQUISIÇÕES
- É possível fazer a busca por room_id ou user_id caso não seja passado nenhum parametro retorna todos os agendamentos

##GET INDEX
request:
```
curl --location --request GET 'localhost:3000/api/v1/schedules?room_id=1'
```
response:
```
{
    "status": "SUCCESS",
    "message": "Schedule list.",
    "data": [
        {
            "id": 2,
            "room_id": 1,
            "user_id": 1,
            "scheduled_at": "2022-06-21T09:00:00.000Z",
            "created_at": "2022-06-21T22:33:52.914Z",
            "updated_at": "2022-06-21T22:33:52.914Z"
        }
    ]
}
```


##POST CREATE
request:
```
curl --location --request POST 'localhost:3000/api/v1/schedules' \
--header 'Content-Type: application/json' \
--data-raw '{
    "room_id": 1,
    "user_id": 1,
    "scheduled_at": "2022-06-28, 10:00 am"
}'
```
response:
```
{
    "status": "SUCCESS",
    "message": "Schedule added.",
    "data": {
        "id": 1,
        "room_id": 1,
        "user_id": 1,
        "scheduled_at": "2022-06-28T10:00:00.000Z",
        "created_at": "2022-06-22T20:25:35.352Z",
        "updated_at": "2022-06-22T20:25:35.352Z"
    }
}
```


##GET SHOW

request:
```
curl --location --request GET 'localhost:3000/api/v1/schedules/1'
```
response:
```
{
    "status": "SUCCESS",
    "message": "Schedule founded.",
    "data": {
        "id": 1,
        "room_id": 1,
        "user_id": 1,
        "scheduled_at": "2022-06-21T10:00:00.000Z",
        "created_at": "2022-06-22T00:10:14.370Z",
        "updated_at": "2022-06-22T00:31:55.593Z"
    }
}
```

##PUT UPDATE

request:
```
curl --location --request PUT 'localhost:3000/api/v1/schedules/1' \
--header 'Content-Type: application/json' \
--data-raw '{
  "scheduled_at": "2022-07-22, 10:00 am"
}'
```
response:
```
{
    "status": "SUCCESS",
    "message": "Schedule updated.",
    "data": {
        "scheduled_at": "2022-07-22T10:00:00",
        "id": 1,
        "room_id": 1,
        "user_id": 1,
        "created_at": "2022-06-22T00:10:14.370Z",
        "updated_at": "2022-06-22T20:33:03.905Z"
    }
}
```



##DELETE DESTROY

request:
```
curl --location --request DELETE 'localhost:3000/api/v1/schedules/1'
```
response:
```
{
    "status": "SUCCESS",
    "message": "Schedule deleted.",
    "data": {
        "id": 1,
        "room_id": 1,
        "user_id": 1,
        "scheduled_at": "2022-07-22T10:00:00.000Z",
        "created_at": "2022-06-22T00:10:14.370Z",
        "updated_at": "2022-06-22T20:33:03.905Z"
    }
}
```

