import Danger
import Foundation

let danger = Danger()
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined(separator: ", "))")

xcov.report(
    scheme: 'MVVMCApp',
    workspace: 'MVVMCApp/project.xcworkspace',
    minimum_coverage_percentage: 90
)

