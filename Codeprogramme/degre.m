function [deg,temp]= degre(u1,u2,u3,u4, input) % on appelle avec (1,2,3,4, SF1.input(1) )
    deg=zeros(1,length(input.mf));
   
    
    for i= 1:length(input.mf),
        
        
        if input.mf(i).params(1)>u4,
            deg(i)=0;
       
        elseif input.mf(i).params(4) < u1,
            deg(i)=0;
        
        elseif (((input.mf(i).params(2)<u2) && (u2<input.mf(i).params(3))) || ((input.mf(i).params(2)<u3)&&(u3<input.mf(i).params(3)))),
            deg(i)=1;
        
        else
                  temp=zeros(1,4);
                  t1=input.mf(i).params(1);
                  t2=input.mf(i).params(2);
                  t3=input.mf(i).params(3);
                  t4=input.mf(i).params(4);
                  temp(1)=(((u1*(t2-t1)-t1*(u2-u1))/(t2-t1-u2+u1))-u1)/(u2-u1);%montante montante
                  temp(2)=(((u1*(t4-t3)+t4*(u2-u1))/(t4-t3+u2-u1))-u1)/(u2-u1);%montante descendante
                  temp(3)=(u4-((u4*(t2-t1)+t1*(u4-u3))/(u4-u3+t2-t1)))/(u4-u3);%descendante montante
                  temp(4)=(u4-((t4*(u4-u3)-u3*(t4-t3))/(u4-u3-t4+t3)))/(u4-u3);%descendante descendante
                  
                  for n=1:4,
                      if temp(n)>1 || temp(n)<0,
                          temp(n)=0;
                      end;
                  end;            
            
            deg(i)= max(temp);
            
            
        end;
        
     end;
    

    