//
//  RetrieveFileContentsExample.swift
//  OpenAIKit
//
//  Copyright (c) 2023 MarcoDotIO
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

import SwiftUI
import OpenAIKit

struct RetrieveFileContentsExample: View {
    @State private var files: [FileContent]?
    @State private var isRetrieving: Bool = false

    var body: some View {
        if isRetrieving {
            VStack {
                if let files = self.files {
                    Text("Retrieved file!")
                    Text("Files size: \(files.count)")
                    Text("First three indexes (see log for full object): ")
                    Text("\(files[0].prompt) - \(files[0].completion)")
                    Text("\(files[1].prompt) - \(files[1].completion)")
                    Text("\(files[2].prompt) - \(files[2].completion)")
                } else {
                    Text("Retrieving file...")
                }
            }
            .padding()
        } else {
            VStack {
                Button {
                    isRetrieving = true
                    
                    Task {
                        do {
                            let config = Configuration(organizationId: "INSERT-ORGANIZATION-ID", apiKey: "INSERT-API-KEY")
                            let openAI = OpenAI(config)

                            self.files = try await openAI.retrieveFileContent(fileId: "INSERT-FILE-ID")
                        } catch {
                            print("ERROR - \(error)")
                        }
                    }
                } label: {
                    Text("Retrieve File Contents")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 270, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding(.top, 8)
                }
            }
        }
    }
}

struct RetrieveFileContentsExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RetrieveFileContentsExample()
        }
    }
}
