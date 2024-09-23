% convert entrez id to gene symbol using matlab using MyGene.info API
function geneSymbol = entrezToGeneSymbolMyGene(entrezID)
  % 
    baseURL = 'https://mygene.info/v3/gene/';
    apiURL = [baseURL, num2str(entrezID), '?fields=symbol'];
    
    options = weboptions('ContentType', 'json');
    try
        % Send request to MyGene API
        response = webread(apiURL, options);
        
        % Extract gene symbol from the response
        if isfield(response, 'symbol')
            geneSymbol = response.symbol;
        else
            geneSymbol = 'Not Found';
            warning(['Entrez Gene ID ', num2str(entrezID), ' not found in MyGene.info database.']);
        end
    catch ME
        geneSymbol = 'Error';
        warning(['Error retrieving data for Entrez Gene ID ', num2str(entrezID), '. Message: ', ME.message]);
    end
end

% % Example usage:
% entrezID = 29979;  % Example Entrez Gene ID for UBQLN1
% geneSymbol = entrezToGeneSymbolMyGene(entrezID);
% disp(['Gene symbol for Entrez ID ', num2str(entrezID), ': ', geneSymbol]);
