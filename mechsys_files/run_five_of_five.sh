BashPath='/home/julia/tests/'
RunPath='/home/julia/coalflow/coalflow'

iterations=(1 2 3 4 5)

angles=(60 180 300)

name1=cutTDM800
name2=cutTDM400
name3=cutTDM200
name4=cutTDM100
name5=cutTDM050

dx1=800
dy1=800
dz1=200

dx2=400
dy2=400
dz2=200

dx3=200
dy3=200
dz3=200

dx4=100
dy4=100
dz4=100

dx5=50
dy5=50
dz5=50


cd
cd $BashPath


BashFile=$(readlink -f $0)
GeomPath=$( printf '%sgeometry' $BashPath)

echo "=============================================="
echo "Step 1"
echo "=============================================="

for i1 in 1
do
    for j1 in 1
    do
        for k1 in "${iterations[@]}"
        do 
            rest='000_000_000_000'
            sampleActive1=$( printf '%01d%01d%01d' $i1 $j1 $k1)
            file=$( printf '%s_%s_%s' $name1 $sampleActive1 $rest)                              

            fileh5=$( printf '%s/%s%s' $GeomPath $file ".h5")                                                            
            fileh5=${fileh5//\//\\/}
            cd $BashPath
            mkdir $file                    

            echo "=============================================="
            echo "Running Sample" $file
        
         cd $BashPath 
         cd $file
    
                for th in "${angles[@]}"
                do
                    echo "th Parameter" $th 
                    mkdir th$th
                    cd th$th
                    cp $BashPath/coalflow.inp .
                    sed -i s/pPath/$fileh5/g coalflow.inp
                    sed -i s/pth/$th/g coalflow.inp
                    sed -i s/pName/$name1/g coalflow.inp
                    sed -i s/pdx/$dx1/g coalflow.inp
                    sed -i s/pdy/$dy1/g coalflow.inp
                    sed -i s/pdz/$dz1/g coalflow.inp

                    $RunPath coalflow 36
                    cd ..
                done
                echo "--------------------------------"
               
                echo "=============================================="
                

                echo "=============================================="
                echo "Step 2"
                echo "=============================================="

                for i2 in 1 2
                do
                    for j2 in 1 2
                    do
                        for k2 in 1
                        do 
                            rest='000_000_000'
                            sampleActive2=$( printf '%s_%01d%01d%01d' $sampleActive1 $i2 $j2 $k2)
                            file=$( printf '%s_%s_%s' $name2 $sampleActive2 $rest)                              
                            echo file
                
                            fileh5=$( printf '%s/%s%s' $GeomPath $file ".h5")                                                            
                            fileh5=${fileh5//\//\\/}
                            cd $BashPath
                            mkdir $file                    
                
                            echo "=============================================="
                            echo "Running Sample" $file
                        
                         cd $BashPath 
                         cd $file
                    
                                for th in "${angles[@]}"
                                do
                                    echo "th Parameter" $th 
                                    mkdir th$th
                                    cd th$th
                                    cp $BashPath/coalflow.inp .
                                    sed -i s/pPath/$fileh5/g coalflow.inp
                                    sed -i s/pth/$th/g coalflow.inp
                                    sed -i s/pName/$name2/g coalflow.inp
                                    sed -i s/pdx/$dx2/g coalflow.inp
                                    sed -i s/pdy/$dy2/g coalflow.inp
                                    sed -i s/pdz/$dz2/g coalflow.inp                
                                    
                                    $RunPath coalflow 36
                                    cd ..
                                done
                                echo "--------------------------------"
                                echo "=============================================="
                
                                echo "=============================================="
                                echo "Step 3"
                                echo "=============================================="
                
                                for i3 in 1 2
                                do
                                    for j3 in 1 2
                                    do
                                        for k3 in 1
                                        do 
                                            rest='000_000'
                                            sampleActive3=$( printf '%s_%01d%01d%01d' $sampleActive2 $i3 $j3 $k3)
                                            file=$( printf '%s_%s_%s' $name3 $sampleActive3 $rest)                              
                                
                                            fileh5=$( printf '%s/%s%s' $GeomPath $file ".h5")                                                            
                                            fileh5=${fileh5//\//\\/}
                                            cd $BashPath
                                            mkdir $file                    
                                
                                            echo "=============================================="
                                            echo "Running Sample" $file
                                        
                                         cd $BashPath 
                                         cd $file
                                    
                                                for th in "${angles[@]}"
                                                do
                                                    echo "th Parameter" $th 
                                                    mkdir th$th
                                                    cd th$th
                                                    cp $BashPath/coalflow.inp .
                                                    sed -i s/pPath/$fileh5/g coalflow.inp
                                                    sed -i s/pth/$th/g coalflow.inp
                                                    sed -i s/pName/$name3/g coalflow.inp
                                                    sed -i s/pdx/$dx3/g coalflow.inp
                                                    sed -i s/pdy/$dy3/g coalflow.inp
                                                    sed -i s/pdz/$dz3/g coalflow.inp
                                                                                  
                                                    $RunPath coalflow 36
                                                    cd ..
                                                done
                                                echo "--------------------------------"
                                                echo "=============================================="
                                

                                                echo "=============================================="
                                                echo "Step 4"
                                                echo "=============================================="
                                
                                                for i4 in 1 2
                                                do
                                                    for j4 in 1 2
                                                    do
                                                        for k4 in 1 2
                                                        do 
                                                            rest='000'
                                                            sampleActive4=$( printf '%s_%01d%01d%01d' $sampleActive3 $i4 $j4 $k4)
                                                            file=$( printf '%s_%s_%s' $name4 $sampleActive4 $rest)                              
                                                
                                                            fileh5=$( printf '%s/%s%s' $GeomPath $file ".h5")                                                            
                                                            fileh5=${fileh5//\//\\/}
                                                            cd $BashPath
                                                            mkdir $file                    
                                                
                                                            echo "=============================================="
                                                            echo "Running Sample" $file
                                                        
                                                         cd $BashPath 
                                                         cd $file
                                                    
                                                                for th in "${angles[@]}"
                                                                do
                                                                    echo "th Parameter" $th 
                                                                    mkdir th$th
                                                                    cd th$th
                                                                    cp $BashPath/coalflow.inp .
                                                                    sed -i s/pPath/$fileh5/g coalflow.inp
                                                                    sed -i s/pth/$th/g coalflow.inp
                                                                    sed -i s/pName/$name4/g coalflow.inp
                                                                    sed -i s/pdx/$dx4/g coalflow.inp
                                                                    sed -i s/pdy/$dy4/g coalflow.inp
                                                                    sed -i s/pdz/$dz4/g coalflow.inp                                                
                                                                    
                                                                    $RunPath coalflow 36
                                                                    cd ..
                                                                done
                                                                echo "--------------------------------"
                                                                echo "=============================================="
                                                
                                                                echo "=============================================="
                                                                echo "Step 5"
                                                                echo "=============================================="
                                                
                                                                for i5 in 1 2
                                                                do
                                                                    for j5 in 1 2
                                                                    do
                                                                        for k5 in 1 2
                                                                        do 
                                                                            sampleActive5=$( printf '%s_%01d%01d%01d' $sampleActive4 $i5 $j5 $k5)
                                                                            file=$( printf '%s_%s' $name5 $sampleActive5)                              
                                                                
                                                                            fileh5=$( printf '%s/%s%s' $GeomPath $file ".h5")                                                            
                                                                            fileh5=${fileh5//\//\\/}
                                                                            cd $BashPath
                                                                            mkdir $file                    
                                                                
                                                                            echo "=============================================="
                                                                            echo "Running Sample" $file
                                                                        
                                                                         cd $BashPath 
                                                                         cd $file
                                                                    
                                                                                for th in "${angles[@]}"
                                                                                do
                                                                                    echo "th Parameter" $th 
                                                                                    mkdir th$th
                                                                                    cd th$th
                                                                                    cp $BashPath/coalflow.inp .
                                                                                    sed -i s/pPath/$fileh5/g coalflow.inp
                                                                                    sed -i s/pth/$th/g coalflow.inp
                                                                                    sed -i s/pName/$name5/g coalflow.inp
                                                                                    sed -i s/pdx/$dx5/g coalflow.inp
                                                                                    sed -i s/pdy/$dy5/g coalflow.inp
                                                                                    sed -i s/pdz/$dz5/g coalflow.inp                                                                
                                                                                    
                                                                                    $RunPath coalflow 36
                                                                                    cd ..
                                                                                done
                                                                                echo "--------------------------------"
                                                                                echo "=============================================="
                                                                
                                                                
                                                                    done
                                                                done
                                                            done
                                

                                                
                                                    done
                                                done
                                            done
                                


                                    done
                                done
                            done


                    done
                done
            done

        done
    done
done

