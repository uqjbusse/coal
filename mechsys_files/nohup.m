function    sas = nohup
%%    
    str = fileread( '/home/uqjbusse/numerical/mechsys_frac_flow/modelling/full_run_11Tpre/test_60_120_180/nohup.txt' ); 
%%
    heading_string  = 'Running Sample';
    trailing_string = '=============================================='; 
    %
    xpr = sprintf( '(?<=%s).+?(?=%s)', heading_string, trailing_string );
    cac = regexp( str, xpr, 'match' );
%% 
    sas = struct( 'SampleName',repmat({''},[1,length(cac)]) ...
                , 'NumOfCells',{[]}, 'Porosity', {[]}       );
    for jj = 1 : length( cac )
        sas(jj) = nohup_( cac{jj} ); 
    end
end
function    sas = nohup_( str )
    %
    sas.SampleName ... 
    =   regexp( str, 'cutTDM\d{3}_\d{3}_\d{3}_\d{3}_\d{3}_\d{3}', 'match', 'once' );
    %
    cac = regexp( str, '(?<=Num of cells +\= *)\d+', 'match' ); 
    sas.NumOfCells = str2double( cac );
    %
    cac = regexp( str, '(?<=Porosity +\= *)[\d+\.]+', 'match' ); 
    sas.Porosity = str2double( cac );
end

