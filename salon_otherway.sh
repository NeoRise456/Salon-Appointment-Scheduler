#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

while true; do
  echo -e "\n ~NeoSalon~ \n"
  echo "1) cut"
  echo "2) perm"
  echo "3) trim"
  echo "4) exit"
  while true; do
    read command
    if ((command < 1 || command > 4)); then
    echo command not found
    else
    break
    fi
  done
  if ((command == 4));then break; fi
  
  
  #get phone
  echo -e "enter your phone[max 10 num]:"
  while true; do
    read phone_in
    if ((phone_in < 1 || phone_in > 10000000000)); then
    
    echo incorrect format
    else
    break
    fi
  done

  #get if new
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$phone_in'")
  if [[ -z $CUSTOMER_NAME ]]
  then 
    #new
    
    #get name max40char
    echo -e"--new customer--\n"
    echo "Whats ur name?"
    read new_name
    CUSTOMER_INFO_INCLUSION=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$phone_in', '$new_name')")
  fi

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$phone_in'")

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $command")
  echo "What time would you like your $SERVICE_NAME,  $CUSTOMER_NAME ?"
  read service_time
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$phone_in'")
  echo $CUSTOMER_ID
  APPOINTMENT_INCLUSION=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $command, '$service_time')")
  echo "your appointment ,$CUSTOMER_NAME, is for $SERVICE_NAME at $service_time"
done

