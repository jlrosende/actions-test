vars=$(echo '{"hola":"a", "adios":"b"}' | jq -r 'to_entries[] | "\(.key)=\(.value)"')
for v in $vars
do
   echo $v
done
