function candycrush()
    clear
    clc
    //Al inicio el usuario tiene 0 puntos en su marcador
    marcador=0
    
    //Pidiendo el nombre al jugador
    nombre=input("Ingresa nombre: ","string")
    
    //Creando tablero con numeros random entre 1 y 10    
    Z=round(rand(8,8)*10)
    
    //TEST MATRIX ONLY
    //Z=zeros(8,8)
    //Z(1:5,1)=1
    //Z(3,2)=1
    //Z(3,1)=0
    
    disp(Z)
    
    //Al principio vas a ejecutar el movimiento 1
    movimientos=1
    while movimientos<=20
        f=10
        c=10
        
        //Validando fila
        while(f<1 | f>8)
            f=input("Escriba el número de fila")
        end
        
        //Validando columna
        while(c<1 | c>8)
            c=input("Escriba el número de columna")
        end
        
        direccion=input("Hacia donde se desea mover (A=Arriba, B=Abajo, D=Derecha, I=Izquierda","string")
        
        select direccion
            case "A" then
                disp("Arriba")
                //Si estoy en la fila de hasta arriba no puedo mover hacia arriba
                if f==1 then
                    disp("Imposible mover hacia arriba")
                //Si estoy en cualquier otra fila si puedo
                elseif (f>=2 & f<=8)
                    [Z,marcador] = cuentarribaborde (marcador,f,c,Z)
                    disp("Se movio: ("+string(f)+","+string(c)+")")
                end
              case "B" then
                  disp("Abajo")
                  //Si estoy en la fila de hasta abajo no puedo mover abajo
                  if f==8 then
                      disp("Imposible mover hacia abajo")
                   //Si estoy en cualquier otra (1-7) si puedo mover abajo
                  elseif (f>=1 & f<=7) then 
                     [Z,marcador] = cuentabajoborde (marcador,f,c,Z)
                     disp("Se movio: ("+string(f)+","+string(c)+")")
                  end
              case "D" then
                  disp("Derecha")
                  //Si estoy en la col 8 no puedo mover a la derecha
                  if c==8 then 
                      disp("Imposible mover a la derecha")
                   //Si estoy en cualquier otra (1-7) si puedo mover derecha
                  elseif c>=1 & c<=7 then
                      [Z,marcador]  = cuentaderechaborde (marcador,f,c,Z)
                      disp("Se movio: ("+string(f)+","+string(c)+")")
                   end 
              case "I" then
                  disp("Izquierda")
                  //Si estoy en la col 1 no puedo mover a la izquierda
                  if c==1 then 
                      disp("Imposible mover a la izquierda")
                   //Si estoy en cualquier otra (2-8) si puedo mover izquierda                      
                  elseif c>=2 & c<=8 then 
                      [Z,marcador]  = cuentaizquierdaborde (marcador,f,c,Z)
                      disp("Se movio: ("+string(f)+","+string(c)+")")
                  end
          end
          //Mostrando tablero después de la modificacion del jugador
          disp(Z)
          disp("Puntos: "+string(marcador))
          disp("Movimientos: "+string(movimientos)+"/20")
          movimientos=movimientos+1
      end
      
      //Nombre y puntos
      disp(nombre+" - - - - - "+string(marcador))
        
      //Escribirlos en un archivo
      u = mopen("C:/Users/farah/resultados.txt", "w")
      mfprintf(u,nombre+" marcador: %i",marcador)
      mclose(u)
endfunction
 

//----------------------------------MOVIMIENTO ARRIBA-----------------------------------
function [matRes, puntos] = cuentarribaborde(marcador,f,c,Z)
      elemento=Z(f,c)
      
      //Si estoy entre los renglones 4 y 8 puede ocurrir que sume puntos vertical
      if f>=4 & f<=8 then
              //Tres iguales despues de moverme a arriba
              if elemento==Z(f-2,c)&elemento==Z(f-3,c) then
                  disp("tres iguales")
                  Z(f,c)=Z(f-1,c)
                  Z(f-2,c)=round(rand(1,1)*10)
                  Z(f-3,c)=round(rand(1,1)*10)
                  Z(f-1,c)=round(rand(1,1)*10)
                  marcador=marcador+10
                  
                  //Checar si puedo hacer otros 3 abajo
                  //  1         1
                  //  1         1
                  //  2    =>   1
                  //  1         2
                  //  2         2
                  //  2         2
                  if(f<=6) then
                     elemento=Z(f,c)
                     if elemento==Z(f+2,c)&elemento==Z(f+1,c) then
                         disp("Tres iguales")
                         Z(f,c)=round(rand(1,1)*10)
                         Z(f+1,c)=round(rand(1,1)*10)
                         Z(f+2,c)=round(rand(1,1)*10)
                         marcador=marcador+10
                     end
                  end
                      
               else
                      //swap
                      Aux=Z(f,c)
                      Z(f,c)=Z(f-1,c)
                      Z(f-1,c)=Aux
                      
                      
                      //Conectar 5
                      //  1  1  2  1  1     1  1  1  1  1
                      //        1        =>       2
                      if(c>=3 & c<=6) then
                          elemento=Z(f-1,c)
                          if elemento==Z(f-1,c+2)&elemento==Z(f-1,c+1)&elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                             disp("Cinco iguales")
                             Z(f-1,c+2)=round(rand(1,1)*10)
                             Z(f-1,c+1)=round(rand(1,1)*10)
                             Z(f-1,c)=round(rand(1,1)*10)
                             Z(f-1,c-1)=round(rand(1,1)*10)
                             Z(f-1,c-2)=round(rand(1,1)*10)
                             marcador=marcador+50
                          end
                     end
                      
                      //Conectar 4 derecha
                      // 1  2  1  1    1  1  1  1
                      //    1       =>    2
                      if(c>=2 & c<=6) then
                          elemento=Z(f-1,c)
                          if elemento==Z(f-1,c-1)&elemento==Z(f-1,c+1)&elemento==Z(f-1,c+2) then
                             disp("4 iguales")
                             Z(f-1,c-1)=round(rand(1,1)*10)
                             Z(f-1,c)=round(rand(1,1)*10)
                             Z(f-1,c+1)=round(rand(1,1)*10)
                             Z(f-1,c+2)=round(rand(1,1)*10)
                             marcador=marcador+30
                          end
                      end
                      
                      //Conectar 4 a la izquierda
                      //  1  1  2  1     1  1  1  1
                      //        1    =>        2
                      if(c>=3 & c<=7) then
                          elemento=Z(f-1,c)
                          if elemento==Z(f-1,c+1)&elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                             disp("Cuatro iguales")
                             Z(f-1,c+1)=round(rand(1,1)*10)
                             Z(f-1,c)=round(rand(1,1)*10)
                             Z(f-1,c-1)=round(rand(1,1)*10)
                             Z(f-1,c-2)=round(rand(1,1)*10)
                             marcador=marcador+30
                          end
                     end
                      
                      //Conectar 3 a la derecha
                      //  2  1  1     1  1  1
                      //  1       =>  2
                      if(c<=6) then
                          elemento=Z(f-1,c)
                          if elemento==Z(f-1,c+1)&elemento==Z(f-1,c+2) then
                             disp("Tres iguales")
                             Z(f-1,c)=round(rand(1,1)*10)
                             Z(f-1,c+1)=round(rand(1,1)*10)
                             Z(f-1,c+2)=round(rand(1,1)*10)
                             marcador=marcador+10
                          end
                     end
                     //Conectar 3 a la izquierda
                      //  1  1  2      1  1  1
                      //        1  =>        2
                      if(c>=3) then
                          elemento=Z(f-1,c)
                          if elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                             disp("Tres iguales")
                             Z(f-1,c)=round(rand(1,1)*10)
                             Z(f-1,c-1)=round(rand(1,1)*10)
                             Z(f-1,c-2)=round(rand(1,1)*10)
                             marcador=marcador+10
                          end
                     end
                     //Conectar 3 abajo
                      //  2    =>   1
                      //  1         2
                      //  2         2
                      //  2         2
                      if(f<=6) then
                         elemento=Z(f,c)
                         if elemento==Z(f+2,c)&elemento==Z(f+1,c) then
                             disp("Tres iguales")
                             Z(f,c)=round(rand(1,1)*10)
                             Z(f+1,c)=round(rand(1,1)*10)
                             Z(f+2,c)=round(rand(1,1)*10)
                             marcador=marcador+10
                         end
                      end
                      
               
                     
                     
               end
        //Si estoy en los renglones de arriba no puedo sumar puntos hacia arriba, 
        //solo intercambiar posiciones
       else
              //swap
              Aux=Z(f,c)
              Z(f,c)=Z(f-1,c)
              Z(f-1,c)=Aux
              
              //Conectar 5
              //  1  1  2  1  1     1  1  1  1  1
              //        1        =>       2
              if(c>=3 & c<=6) then
                  elemento=Z(f-1,c)
                  if elemento==Z(f-1,c+2)&elemento==Z(f-1,c+1)&elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                     disp("Cinco iguales")
                     Z(f-1,c+2)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+50
                  end
             end
              
              //Conectar 4 derecha
              // 1  2  1  1    1  1  1  1
              //    1       =>    2
              if(c>=2 & c<=6) then
                  elemento=Z(f-1,c)
                  if elemento==Z(f-1,c-1)&elemento==Z(f-1,c+1)&elemento==Z(f-1,c+2) then
                     disp("4 iguales")
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+2)=round(rand(1,1)*10)
                     marcador=marcador+30
                  end
              end
              
              //Conectar 4 a la izquierda
              //  1  1  2  1     1  1  1  1
              //        1    =>        2
              if(c>=3 & c<=7) then
                  elemento=Z(f-1,c)
                  if elemento==Z(f-1,c+1)&elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                     disp("Cuatro iguales")
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+30
                  end
             end
                      
              //Conectar 3 a la derecha
              //  2  1  1     1  1  1
              //  1       =>  2
              if(c<=6) then
                  elemento=Z(f-1,c)
                  if elemento==Z(f-1,c+1)&elemento==Z(f-1,c+2) then
                     disp("Tres iguales")
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+2)=round(rand(1,1)*10)
                     marcador=marcador+10
                  end
             end
             //Conectar 3 a la izquierda
              //  1  1  2      1  1  1
              //        1  =>        2
              if(c>=3) then
                  elemento=Z(f-1,c)
                  if elemento==Z(f-1,c-1)&elemento==Z(f-1,c-2) then
                     disp("Tres iguales")
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+10
                  end
             end
             //Checar si puedo hacer otros 3 abajo
              //  2    =>   1
              //  1         2
              //  2         2
              //  2         2
              if(f<=6) then
                 elemento=Z(f,c)
                 if elemento==Z(f+2,c)&elemento==Z(f+1,c) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+2,c)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
              end
       end
        
        //Regresando la matriz con los cambios hechos y el puntaje
        matRes = Z
        puntos = marcador
 endfunction
 
 
//----------------------------------MOVIMIENTO ABAJO-----------------------------------
 function [matRes, puntos] = cuentabajoborde(marcador,f,c,Z)
     elemento=Z(f,c)
     //Si estoy entre 1 y 5 podría sumar puntos vertical
     if f>=1 & f<=5 then
         if elemento==Z(f+2,c)&elemento==Z(f+3,c) then
             disp("Tres iguales")
             Z(f,c)=Z(f+1,c)
             Z(f+1,c)=round(rand(1,1)*10)
             Z(f+2,c)=round(rand(1,1)*10)
             Z(f+3,c)=round(rand(1,1)*10)
             marcador=marcador+10
             
              //Checar si puedo hacer otros 3 arriba
              //  1         1
              //  1         1
              //  2    =>   1
              //  1         2
              //  2         2
              //  2         2
              if(f>=3) then
                 elemento=Z(f,c)
                 if elemento==Z(f-2,c)&elemento==Z(f-1,c) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-2,c)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
              end
         else 
             //swap
              Aux=Z(f,c)
              Z(f,c)=Z(f+1,c)
              Z(f+1,c)=Aux
              
                            
              //Conectar 5
              //        1        =>       2
              //  1  1  2  1  1     1  1  1  1  1
              
              if(c>=3 & c<=6) then
                  elemento=Z(f+1,c)
                  if elemento==Z(f+1,c+2)&elemento==Z(f+1,c+1)&elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                     disp("Cinco iguales")
                     Z(f+1,c+2)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+50
                  end
             end
              
              //Conectar 4 derecha
              //    1       =>    2
              // 1  2  1  1    1  1  1  1
              if(c>=2 & c<=6) then
                  elemento=Z(f+1,c)
                  if elemento==Z(f+1,c-1)&elemento==Z(f+1,c+1)&elemento==Z(f+1,c+2) then
                     disp("4 iguales")
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f+1,c+2)=round(rand(1,1)*10)
                     marcador=marcador+30
                  end
              end
              
              //Conectar 4 a la izquierda
              //        1    =>        2

              //  1  1  2  1     1  1  1  1
          
              if(c>=3 & c<=7) then
                  elemento=Z(f+1,c)
                  if elemento==Z(f+1,c+1)&elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                     disp("Cuatro iguales")
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+30
                  end
             end
              
              
              //Conectar 3 a la derecha
              //  1       =>  2
              //  2  1  1     1  1  1
              if(c<=6) then
                  elemento=Z(f+1,c)
                  if elemento==Z(f+1,c+1)&elemento==Z(f+1,c+2) then
                     disp("Tres iguales")
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f+1,c+2)=round(rand(1,1)*10)
                     marcador=marcador+10
                  end
             end
             
              //Conectar 3 a la izquierda
              //        1  =>        2
              //  1  1  2      1  1  1
              if(c>=3) then
                  elemento=Z(f+1,c)
                  if elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                     disp("Tres iguales")
                     Z(f+1,c)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-2)=round(rand(1,1)*10)
                     marcador=marcador+10
                  end
             end
             
              //Checar si puedo hacer otros 3 arriba
              //  1         1
              //  1         1
              //  2    =>   1
              //  1         2
              if(f>=3) then
                 elemento=Z(f,c)
                 if elemento==Z(f-2,c)&elemento==Z(f-1,c) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f-1,c)=round(rand(1,1)*10)
                     Z(f-2,c)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
              end
            end
    //Si estoy en otro renglon solo puedo intercambiar
    else 
         //swap
          Aux=Z(f,c)
          Z(f,c)=Z(f+1,c)
          Z(f+1,c)=Aux
                                      
          //Conectar 5
          //        1        =>       2
          //  1  1  2  1  1     1  1  1  1  1
          
          if(c>=3 & c<=6) then
              elemento=Z(f+1,c)
              if elemento==Z(f+1,c+2)&elemento==Z(f+1,c+1)&elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                 disp("Cinco iguales")
                 Z(f+1,c+2)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f+1,c)=round(rand(1,1)*10)
                 Z(f+1,c-1)=round(rand(1,1)*10)
                 Z(f+1,c-2)=round(rand(1,1)*10)
                 marcador=marcador+50
              end
         end
          
          //Conectar 4 derecha
          //    1       =>    2
          // 1  2  1  1    1  1  1  1
          if(c>=2 & c<=6) then
              elemento=Z(f+1,c)
              if elemento==Z(f+1,c-1)&elemento==Z(f+1,c+1)&elemento==Z(f+1,c+2) then
                 disp("4 iguales")
                 Z(f+1,c-1)=round(rand(1,1)*10)
                 Z(f+1,c)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f+1,c+2)=round(rand(1,1)*10)
                 marcador=marcador+30
              end
          end
          
          //Conectar 4 a la izquierda
          //        1    =>        2
          //  1  1  2  1     1  1  1  1
      
          if(c>=3 & c<=7) then
              elemento=Z(f+1,c)
              if elemento==Z(f+1,c+1)&elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                 disp("Cuatro iguales")
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f+1,c)=round(rand(1,1)*10)
                 Z(f+1,c-1)=round(rand(1,1)*10)
                 Z(f+1,c-2)=round(rand(1,1)*10)
                 marcador=marcador+30
              end
         end
          //Conectar 3 a la derecha
          //  1       =>  2
          //  2  1  1     1  1  1
          if(c<=6) then
              elemento=Z(f+1,c)
              if elemento==Z(f+1,c+1)&elemento==Z(f+1,c+2) then
                 disp("Tres iguales")
                 Z(f+1,c)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f+1,c+2)=round(rand(1,1)*10)
                 marcador=marcador+10
              end
         end
         
          //Conectar 3 a la izquierda
          //        1  =>        2
          //  1  1  2      1  1  1
          if(c>=3) then
              elemento=Z(f+1,c)
              if elemento==Z(f+1,c-1)&elemento==Z(f+1,c-2) then
                 disp("Tres iguales")
                 Z(f+1,c)=round(rand(1,1)*10)
                 Z(f+1,c-1)=round(rand(1,1)*10)
                 Z(f+1,c-2)=round(rand(1,1)*10)
                 marcador=marcador+10
              end
         end
         
          //Checar si puedo hacer otros 3 arriba
          //  1         1
          //  1         1
          //  2    =>   1
          //  1         2
          if(f>=3) then
             elemento=Z(f,c)
             if elemento==Z(f-2,c)&elemento==Z(f-1,c) then
                 disp("Tres iguales")
                 Z(f,c)=round(rand(1,1)*10)
                 Z(f-1,c)=round(rand(1,1)*10)
                 Z(f-2,c)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
          end
        end
    //Regresando la matriz con los cambios hechos y el puntaje
    matRes = Z
    puntos = marcador
endfunction

//----------------------------------MOVIMIENTO A LA DERECHA-----------------------------------
 function [matRes, puntos] = cuentaderechaborde(marcador,f,c,Z)
     elemento=Z(f,c)
     //Si estoy entre columnas 1 y 5 puedo sumar horizontal
     if c>=1 & c<=5
         
         //conectar 3 despues de moverme a la derecha
         //1 2 1 1  =>  2 1 1 1
         if elemento==Z(f,c+2)&elemento==Z(f,c+3) then
             disp("Tres iguales")
             Z(f,c)=Z(f,c+1)
             Z(f,c+1)=round(rand(1,1)*10)
             Z(f,c+2)=round(rand(1,1)*10)
             Z(f,c+3)=round(rand(1,1)*10)
             marcador=marcador+10
             
             //conectar otros 3 a la izquierda
             //2 2 1 2 1 1 => 2 2 2 1 1 1
             if(c>=3) then
                 elemento=Z(f,c)
                 if elemento==Z(f,c-2)&elemento==Z(f,c-1) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f,c-2)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
         else
             //Swap
             Aux=Z(f,c)
             Z(f,c)=Z(f,c+1)
             Z(f,c+1)=Aux
             
             //Conectar 5
             //    1          1
             //    1    =>    1
             //  1 2       2  1
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c+1)
                 if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1)&elemento==Z(f+2,c+1) then
                     disp("Cinco iguales")
                     Z(f+2,c+1)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-2,c+1)=round(rand(1,1)*10)
                     marcador=marcador+50
                 end
             end
             
             //Conectar 4 arriba
             //    1          1
             //    1    =>    1
             //  1 2       2  1
             //    1          1
             if(f>=3 & f<=7) then
                 elemento=Z(f,c+1)
                 if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1) then
                     disp("Cuatro iguales")
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-2,c+1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
             
             //Conectar 4 abajo
             //    1    =>    1
             //  1 2       2  1
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c+1)
                 if elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1)&elemento==Z(f+2,c+1) then
                     disp("Cuatro iguales")
                     Z(f+2,c+1)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
             //Conectar con 3 arriba
             //    1          1
             //    1    =>    1
             //  1 2       2  1
             if(f>=3) then
                 elemento=Z(f,c+1)
                 if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1) then
                     disp("Tres iguales")
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f-1,c+1)=round(rand(1,1)*10)
                     Z(f-2,c+1)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
             
             //Conectar con 3 abajo
             // 1  2       2  1
             //    1    =>    1
             //    1          1
             if(f<=6) then
                 elemento=Z(f,c+1)
                 if elemento==Z(f+2,c+1)&elemento==Z(f+1,c+1) then
                     disp("Tres iguales")
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f+1,c+1)=round(rand(1,1)*10)
                     Z(f+2,c+1)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
             
             //conectar otros 3 a la izquierda
             //2 2 1 2  => 2 2 2 1 
             if(c>=3) then
                 elemento=Z(f,c)
                 if elemento==Z(f,c-2)&elemento==Z(f,c-1) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f,c-2)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
         end 
     else
         //Swap
         Aux=Z(f,c)
         Z(f,c)=Z(f,c+1)
         Z(f,c+1)=Aux
         //Conectar 5
         //    1          1
         //    1    =>    1
         //  1 2       2  1
         //    1          1
         //    1          1
         if(f>=3 & f<=6) then
             elemento=Z(f,c+1)
             if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1)&elemento==Z(f+2,c+1) then
                 disp("Cinco iguales")
                 Z(f+2,c+1)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f-1,c+1)=round(rand(1,1)*10)
                 Z(f-2,c+1)=round(rand(1,1)*10)
                 marcador=marcador+50
             end
         end
         
         //Conectar 4 arriba
         //    1          1
         //    1    =>    1
         //  1 2       2  1
         //    1          1
         if(f>=3 & f<=7) then
             elemento=Z(f,c+1)
             if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1) then
                 disp("Cuatro iguales")
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f-1,c+1)=round(rand(1,1)*10)
                 Z(f-2,c+1)=round(rand(1,1)*10)
                 marcador=marcador+30
             end
         end
         
         //Conectar 4 abajo
         //    1    =>    1
         //  1 2       2  1
         //    1          1
         //    1          1
         if(f>=3 & f<=6) then
             elemento=Z(f,c+1)
             if elemento==Z(f-1,c+1)&elemento==Z(f+1,c+1)&elemento==Z(f+2,c+1) then
                 disp("Cuatro iguales")
                 Z(f+2,c+1)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f-1,c+1)=round(rand(1,1)*10)
                 marcador=marcador+30
             end
         end
         //Conectar con 3 arriba
         //    1          1
         //    1    =>    1
         //  1 2       2  1
         if(f>=3) then
             elemento=Z(f,c+1)
             if elemento==Z(f-2,c+1)&elemento==Z(f-1,c+1) then
                 disp("Tres iguales")
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f-1,c+1)=round(rand(1,1)*10)
                 Z(f-2,c+1)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
         
         //Conectar con 3 abajo
         // 1  2       2  1
         //    1    =>    1
         //    1          1
         if(f<=6) then
             elemento=Z(f,c+1)
             if elemento==Z(f+2,c+1)&elemento==Z(f+1,c+1) then
                 disp("Tres iguales")
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f+1,c+1)=round(rand(1,1)*10)
                 Z(f+2,c+1)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
         
         //conectar otros 3 a la izquierda
         //2 2 1 2  => 2 2 2 1 
         if(c>=3) then
             elemento=Z(f,c)
             if elemento==Z(f,c-2)&elemento==Z(f,c-1) then
                 disp("Tres iguales")
                 Z(f,c)=round(rand(1,1)*10)
                 Z(f,c-1)=round(rand(1,1)*10)
                 Z(f,c-2)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
     end
 
    //Regresando la matriz con los cambios hechos y el puntaje
    matRes = Z
    puntos = marcador
    
 endfunction
 
 
 //----------------------------------MOVIMIENTO A LA IZQUIERDA-----------------------------------
  function [matRes, puntos] = cuentaizquierdaborde(marcador,f,c,Z)
     elemento=Z(f,c)
      //Si estoy entre columnas 4 y 8 puedo sumar horizontal
     if c>=4 & c<=8
         if elemento==Z(f,c-2)&elemento==Z(f,c-3) then
             disp("Tres iguales")
             Z(f,c)=Z(f,c-1)
             Z(f,c-1)=round(rand(1,1)*10)
             Z(f,c-2)=round(rand(1,1)*10)
             Z(f,c-3)=round(rand(1,1)*10)
             marcador=marcador+10
             
             //conectar otros 3 a la derecha
             //2 2 1 2 1 1 => 2 2 2 1 1 1
             if(c<=6) then
                 elemento=Z(f,c)
                 if elemento==Z(f,c+2)&elemento==Z(f,c+1) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f,c+2)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
         else
             //swap
              Aux=Z(f,c)
              Z(f,c)=Z(f,c-1)
              Z(f,c-1)=Aux
              
             //Conectar 5
             //    1          1
             //    1    =>    1
             //    2  1       1  2
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1)&elemento==Z(f+2,c-1) then
                     disp("Cinco iguales")
                     Z(f+2,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+50
                 end
             end
             
             //Conectar 4 arriba
             //    1          1
             //    1    =>    1
             //  1 2       2  1
             //    1          1
             if(f>=3 & f<=7) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1) then
                     disp("Cuatro iguales")
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
             
             //Conectar 4 abajo
             //    1    =>    1
             //    2  1       1  2
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1)&elemento==Z(f+2,c-1) then
                     disp("Cuatro iguales")
                     Z(f+2,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
             //Conectar con 3 arriba
             //    1         1
             //    1     =>  1
             //    2  1      1  2
             if(f>=3) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1) then
                     disp("Tres iguales")
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
             
             //Conectar con 3 abajo
             //    2  1      1  2
             //    1     =>  1
             //    1         1
             if(f<=6) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f+2,c-1)&elemento==Z(f+1,c-1) then
                     disp("Tres iguales")
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f+2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
             //conectar otros 3 a la derecha
             //1 2 1 1 => 2 1 1 1
             if(c<=6) then
                 elemento=Z(f,c)
                 if elemento==Z(f,c+2)&elemento==Z(f,c+1) then
                     disp("Tres iguales")
                     Z(f,c)=round(rand(1,1)*10)
                     Z(f,c+1)=round(rand(1,1)*10)
                     Z(f,c+2)=round(rand(1,1)*10)
                     marcador=marcador+10
                 end
             end
        end
     else
         //swap
          Aux=Z(f,c)
          Z(f,c)=Z(f,c-1)
          Z(f,c-1)=Aux
          //Conectar 5
             //    1          1
             //    1    =>    1
             //    2  1       1  2
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1)&elemento==Z(f+2,c-1) then
                     disp("Cinco iguales")
                     Z(f+2,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+50
                 end
             end
             
             //Conectar 4 arriba
             //    1          1
             //    1    =>    1
             //  1 2       2  1
             //    1          1
             if(f>=3 & f<=7) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1) then
                     disp("Cuatro iguales")
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     Z(f-2,c-1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
             
             //Conectar 4 abajo
             //    1    =>    1
             //    2  1       1  2
             //    1          1
             //    1          1
             if(f>=3 & f<=6) then
                 elemento=Z(f,c-1)
                 if elemento==Z(f-1,c-1)&elemento==Z(f+1,c-1)&elemento==Z(f+2,c-1) then
                     disp("Cuatro iguales")
                     Z(f+2,c-1)=round(rand(1,1)*10)
                     Z(f+1,c-1)=round(rand(1,1)*10)
                     Z(f,c-1)=round(rand(1,1)*10)
                     Z(f-1,c-1)=round(rand(1,1)*10)
                     marcador=marcador+30
                 end
             end
         //Conectar con 3 arriba
         //    1         1
         //    1     =>  1
         //    2  1      1  2
         if(f>=3) then
             elemento=Z(f,c-1)
             if elemento==Z(f-2,c-1)&elemento==Z(f-1,c-1) then
                 disp("Tres iguales")
                 Z(f,c-1)=round(rand(1,1)*10)
                 Z(f-1,c-1)=round(rand(1,1)*10)
                 Z(f-2,c-1)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
         
         //Conectar con 3 abajo
         //    2  1      1  2
         //    1     =>  1
         //    1         1
         if(f<=6) then
             elemento=Z(f,c-1)
             if elemento==Z(f+2,c-1)&elemento==Z(f+1,c-1) then
                 disp("Tres iguales")
                 Z(f,c-1)=round(rand(1,1)*10)
                 Z(f+1,c-1)=round(rand(1,1)*10)
                 Z(f+2,c-1)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
         //conectar otros 3 a la derecha
         //1 2 1 1 => 2 1 1 1
         if(c<=6) then
             elemento=Z(f,c)
             if elemento==Z(f,c+2)&elemento==Z(f,c+1) then
                 disp("Tres iguales")
                 Z(f,c)=round(rand(1,1)*10)
                 Z(f,c+1)=round(rand(1,1)*10)
                 Z(f,c+2)=round(rand(1,1)*10)
                 marcador=marcador+10
             end
         end
    end
    //Regresando la matriz con los cambios hechos y el puntaje
    matRes = Z
    puntos = marcador
 endfunction
