# [Apache AGE](https://github.com/apache/incubator-age) and [AGViewer](https://github.com/bitnine-oss/AGViewer)

Test them with a docker compose file.

### Notes

This uses a Dockerfile copied from [sorrell/agensgraph-extension](https://hub.docker.com/r/sorrell/agensgraph-extension) on docker hub. This let us test AGE with an image updated with the latest code.

To use the Sorrel's image in docker hub, switch to the sorrel-image git branch in this repo.

To try Age and AGViewer, use `docker-compose up` .

AGViewer can be accessed at http://localhost:3001/

The inputs to enter in the connection form will depend of the values in the compose file and the docker.env:

- Database Type: Apache Age
- Connect URL: age
- Connect Port: 5432
- Database Name: agedb
- Graph Path: my_graph_name
- User Name: postgres
- Password: postgres

### Some query and mutations

The test follows the examples of [sorrell/agensgraph-extension](https://hub.docker.com/r/sorrell/agensgraph-extension) on docker hub

Create some nodes:

```SQl
SELECT * from cypher('my_graph_name', $$
  CREATE (a:Part {part_num: '123'}),
         (b:Part {part_num: '345'}),
         (c:Part {part_num: '456'}),
         (d:Part {part_num: '789'})
$$) as (a agtype);
```

Query the graph:

```SQL
SELECT * from cypher('my_graph_name', $$
  MATCH (a)
  RETURN a
$$) as (a agtype);
```

Create some relations:

```SQL
SELECT * from cypher('my_graph_name', $$
  MATCH (a:Part {part_num: '123'}), (b:Part {part_num: '345'})
  CREATE (a)-[u:used_by { quantity: 1 }]->(b)
$$) as (a agtype);
```

Querying the relations gives an error:

```sql
SELECT * from cypher('my_graph_name', $$
  MATCH p=(a)-[]-(b)
  RETURN p
$$) as (a agtype);
```

> Unexpected token : in JSON at position 76
