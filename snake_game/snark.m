function snark ()

max_x = 20;
max_y = 20;
grid = zeros(max_x,max_y);

x = 5;
y = 5;
grid(x,y) = 1;

length = 1;    
positionX = zeros(length);
positionY = zeros(length);  
positionX(1) = x;
positionY(1) = y;

%Position of the food.
x_f = x;
y_f = y;
getNewFood()

justGotFoodFlag = 0;
gameover = 0;

h_fig = figure;

set(h_fig,'menubar','none');

set(h_fig,'CurrentObject',imagesc(grid));
set(h_fig,'KeyPressFcn',@keyPress);

    function keyPress (~,evt)
        youGottaMove(evt.Key);
        
        while(~gameover)
            pause(0.1);
            youGottaMove(evt.Key);
        end
    end
   
    function youGottaMove(mov)
        makeMovement(mov);
        
        if ~gameover    
            checkBody();
            if ~gameover
                justGotFoodFlag = 0;

                grid(positionX(1),positionY(1)) = 0;

                if (length~=1)
                    for i = 1:length-1
                        positionX(i) = positionX(i+1);
                        positionY(i) = positionY(i+1);
                    end
                end

                positionX(length) = x;
                positionY(length) = y;

                checkPosEqFood()

                grid(x,y) = 1;
                set(h_fig,'CurrentObject',imagesc(grid));
            end
        end
    end
    
    function makeMovement(mov)
        tmp = 1;
        while tmp
            switch(mov)
                case 'downarrow'
                    if (x==max_x)
                        gameOver();
                        break;
                    end
                    x=x+1;
                case 'uparrow'
                    if (x==1)
                        gameOver();
                        break;
                    end
                    x=x-1;
                case 'rightarrow'
                    if (y==max_y)
                        gameOver();
                        break;
                    end
                    y=y+1;
                case 'leftarrow'
                    if (y==1)
                        gameOver();
                        break;
                    end
                    y=y-1;
            end
        tmp = 0;    
        end
    end

    function checkBody() 
        if (length~=1)
            for i=1:length-justGotFoodFlag
                if (x==positionX(i))&&(y==positionY(i))
                    gameOver();
                    break;
                end
            end
        end
        
    end

    function checkPosEqFood() 
        if (x==x_f)&&(y==y_f)
            length = length + 1;
            positionX(length) = x;
            positionY(length) = y;
            getNewFood();
            justGotFoodFlag = 1;
        end
    end

    function getNewFood()
        flag = 1;
        while (flag)
                x_f = randi(max_x);
                y_f = randi(max_y);
                flag = 0;
                for i = 1:length
                    if (x_f==positionX(i))&&(y_f==positionY(i))
                        flag=1;
                    end
                end
        end
        grid(x_f,y_f) = 0.5;
    end

    function doNothing(~,~)
    end

    function gameOver()
       set(h_fig,'KeyPressFcn',@doNothing);
       grid(:,:) = 0.2;
       set(h_fig,'CurrentObject',imagesc(grid));
       pause(1);
       close (h_fig);
       disp('Game over, you suck!');
       gameover = 1;
    end

end