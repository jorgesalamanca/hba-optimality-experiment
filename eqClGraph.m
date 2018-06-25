eqGraph = zeros(length(eqClX),2);

for i=1:length(eqClX)
   if i~= length(eqClX)
       eqGraph(i,:) = [eqClX(i),eqClX(i+1)];
   else
       eqGraph(i,:) = [eqClX(i),0];
   end
end