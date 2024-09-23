function ensemblID = geneSymbolToEnsemblID(geneSymbol)
    baseURL = 'https://rest.ensembl.org/xrefs/symbol/homo_sapiens/';
    options = weboptions('ContentType', 'json');
    apiURL = [baseURL, geneSymbol, '?content-type=application/json'];
    
    try
        response = webread(apiURL, options);
        ensemblID = response.id;
    catch
        ensemblID = 'Not Found';
        warning('Gene symbol not found in Ensembl database.');
    end
end

% % Example usage:
% geneSymbol = 'UBQLN1';
% ensemblID = geneSymbolToEnsemblID(geneSymbol);
% disp(['Ensembl ID for ', geneSymbol, ': ', ensemblID]);
