//
//  FeedViewController+Delegates.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/26/20.
//

import UIKit

extension FeedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { fatalError() }
        let postVM = postViewModel[indexPath.row]
        cell.postViewModel = postVM
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if tableView.contentSize.height > tableView.frame.height && position > tableView.contentSize.height - tableView.frame.height - 50 {
            guard !PostViewModel.isFetchingData else {
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
            print("FETCHING! Total rows:\(postViewModel.count)")
            PostViewModel.fetchFeed(viewModel: &postViewModel, pagination: true, afterlink: PostViewModel.after ?? "")
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}
